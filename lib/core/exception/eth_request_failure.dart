import 'eth_failure.dart';

/// EthRequestFailure
class EthRequestFailure implements Exception {
  const EthRequestFailure([this.message = 'An Error Occured']);
  final String message;

  factory EthRequestFailure.fromEthFailure(EthFailure err) =>
      EthRequestFailure(err.message);

  @override
  String toString() => 'EthRequestFailure(message: $message)';
  EthFailure toEthFailure() => EthFailure.fromEthRequestFailure(this);
}
