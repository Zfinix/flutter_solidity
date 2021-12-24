import 'package:flutter_solidity/core/web3/src/api_urls.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

class AuthenticatedWeb3Client extends Web3Client {
  AuthenticatedWeb3Client()
      : this.custom(
          JsonRPC(
            ApiURL.rpcBaseUrl,
            ApiURL.httpClient,
          ),
        );

  AuthenticatedWeb3Client.custom(
    RpcService rpc, {
    SocketConnector? socketConnector,
  }) : super.custom(
          rpc,
          socketConnector: socketConnector,
        );
}
