import 'package:dio/dio.dart';
import 'package:flutter_solidity/core/exception/exception.dart';
import 'package:flutter_solidity/utils/logger.dart';
import 'package:flutter_solidity/utils/pretty_json.dart';
import 'package:pedantic/pedantic.dart';

class AuthenticatedDioClient {
  AuthenticatedDioClient() {
    _dio.options.responseType = ResponseType.plain;
    _dio.interceptors.add(InterceptorsWrapper(requestInterceptor));
  }

  final _dio = Dio();

  // Use a memory cache to avoid local storage access in each call
  String _inMemoryToken = '';

  /*  Future<String?> get userId async {
    final user = await Storage.getLoginData();
    return user?.data.id;
  } */

  Future<String> get userAccessToken async {
    try {
      // use token availabe in memory if available
      if (_inMemoryToken.isNotEmpty) return _inMemoryToken;

      // otherwise load it from local storage
      _inMemoryToken = await _loadTokenFromSharedPreference();
    } catch (e) {
      /// Throw no error
    }
    return _inMemoryToken;
  }

  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<Response<String>> get(
    String path, {
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onReceiveProgress,
  }) async {
    final resp = await _dio.get<String>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<Response<String>> head(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final resp = await _dio.head<String>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<Response<String>> patch(
    String path, {
    dynamic data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    final resp = await _dio.patch<String>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<Response<String>> post(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    final resp = await _dio.post<String>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<Response<String>> put(
    String path, {
    data,
    Map<String, Object>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    final resp = await _dio.put<String>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    unawaited(_logoutUserIfUnauthorized(resp));
    return resp;
  }

  Future<String> _loadTokenFromSharedPreference() async {
    try {
      var accessToken = '';

      // If user is already authenticated, we can load his token from cache

      //  final user = await Storage.getLoginData();
      // if (user != null) accessToken = user.data.accessToken;

      return accessToken;
    } catch (e) {
      return '';
    }
  }

  // Don't forget to reset the cache when logging out the user
  void resetMemoryCachedToken() {
    _inMemoryToken = '';
  }

  Future<void> _logoutUserIfUnauthorized(Response response) async {
    /*  final data = await Storage.getLoginData();
    final isUserLoggedIn = data != null && data.data.jwt.isNotEmpty;

    if (response.statusCode == 401 && isUserLoggedIn ||
        response.data != null &&
            response.data.toString().toLowerCase().contains('unauthorized')) {
      resetMemoryCachedToken();

      await Storage.eraseLoginData();
      navigator
        ..popToFirst()
        ..replaceRoot(LoginPage());
    } */
  }

  void requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = await userAccessToken;

    if (token.isNotEmpty) {
      options.headers.putIfAbsent(
        'Authorization',
        () => 'Bearer $token',
      );
    }
    options.headers.putIfAbsent(
      'Content-type',
      () => 'application/json;charset=UTF-8',
    );
    options.headers.putIfAbsent(
      'Accept',
      () => 'application/json;charset=UTF-8',
    );

    return handler.next(options);
  }
}

class InterceptorsWrapper extends Interceptor {
  InterceptorsWrapper(this.requestInterceptor);
  void Function(RequestOptions options, RequestInterceptorHandler handler)
      requestInterceptor;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    logger
      ..d('URL -> ${options.uri.path}')
      ..i('Data -> ${jsonPretty(options.data)}');
    return requestInterceptor(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger
      ..d('Status Code -> ${response.statusCode}')
      ..i('Response -> ${jsonPretty(response.data)}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger
      ..d('Status Code -> ${err.response?.statusCode}')
      ..i('Error Response -> ${jsonPretty(err.response?.data)}');
    super.onError(err, handler);
  }
}

void handleResponse(Response<String> res) {
  if (res.data == null || res.data!.isEmpty) {
    throw const EthRequestFailure();
  }
  switch (res.statusCode) {
    case 200:
      break;
    case 201:
      break;
    default:
      throw const EthRequestFailure();
  }
}
