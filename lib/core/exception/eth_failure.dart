// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter_solidity/core/exception/exception.dart';
import 'package:equatable/equatable.dart';

class EthFailure with EquatableMixin {
  const EthFailure({
    this.status = false,
    required this.message,
  });

  final bool status;
  final String message;

  EthFailure copyWith({
    bool? status,
    String? message,
  }) {
    return EthFailure(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory EthFailure.fromMap(Map<String, dynamic> map) {
    return EthFailure(
      status: (map['status'] ?? false) as bool,
      message: (map['message'] ?? map['errors']['message']) as String,
    );
  }

  factory EthFailure.fromEthRequestFailure(EthRequestFailure err) {
    return EthFailure(message: err.message);
  }

  String toJson() => json.encode(toMap());

  factory EthFailure.fromJson(String source) {
    try {
      return EthFailure.fromMap(json.decode(source));
    } catch (e) {
      return const EthFailure(
        message: 'Unable to Log you In',
      );
    }
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message];
}
