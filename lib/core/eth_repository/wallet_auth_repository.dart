import 'package:flutter_solidity/core/exception/exception.dart';
import 'package:flutter_solidity/core/web3/web3.dart';
import 'package:dartz/dartz.dart';
import 'package:web3dart/web3dart.dart';

class FlSoliditytAuthRepository {
  FlSoliditytAuthRepository({
    FlSoliditytAuthWeb3Client? accountsApiClient,
  }) : _web3Client = accountsApiClient ?? FlSoliditytAuthWeb3Client();

  final FlSoliditytAuthWeb3Client _web3Client;

  /// Call smart contract
  Future<Either<EthFailure, List<dynamic>>> callContract({
    EthereumAddress? sender,
    required DeployedContract contract,
    required ContractFunction function,
    required List<dynamic> params,
    BlockNum? atBlock,
  }) async {
    try {
      final res = await _web3Client.call(
        contract: contract,
        function: function,
        sender: sender,
        params: params,
        atBlock: atBlock,
      );

      return Right(res);
    } catch (e) {
      if (e is EthRequestFailure) {
        return Left(e.toEthFailure());
      }
      return const Left(
        EthFailure(
          message: 'Unable to validate  mnemonic',
        ),
      );
    }
  }
}
