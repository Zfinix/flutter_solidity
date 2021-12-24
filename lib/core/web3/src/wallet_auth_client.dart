import 'package:wallet_core/wallet_core.dart';
import 'package:web3dart/web3dart.dart';

import 'package:flutter_solidity/core/web3/web3.dart';

/// {@template wallet_auth_client}
/// Dart API Client which wraps the [AuthenticatedWeb3Client]().
/// {@endtemplate}
class FlSoliditytAuthWeb3Client extends AuthenticatedWeb3Client {
  /// {@macro wallet_auth_client}
  FlSoliditytAuthWeb3Client({
    Web3Client? client,
  }) : _client = client ?? AuthenticatedWeb3Client();

  final Web3Client _client;
}
