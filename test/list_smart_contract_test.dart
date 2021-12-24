import 'dart:math';

import 'package:flutter_solidity/contracts/abi/simple_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  group('Smart Contract Test', () {
    var apiUrl = 'http://localhost:7545'; //Replace with your API
    final client = Web3Client(apiUrl, Client());

    final credentials = EthPrivateKey.fromHex(
      '12889a81fab17152a1b3374e973edfd288a226cbc7745b63543b7c0e02e47355',
    );

    final contractAddr = EthereumAddress.fromHex(
      '0x7547587bC874e2d35197206FEf34C84FEEfF1202',
    );

    // read the contract abi and tell web3dart where it's deployed (contractAddr)
    final contract = DeployedContract(
      ContractAbi.fromJson(simpleListAbi, 'SimpleListContract'),
      contractAddr,
    );

    // Extracting some functions that we'll need later
    final getPeople = contract.function('getPeople');
    final addPerson = contract.function('addPerson');
    final removePerson = contract.function('removePerson');
    test('Add ownAddress to Blockchain', () async {
      final ownAddress = await credentials.extractAddress();

      await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: addPerson,
          parameters: [ownAddress],
        ),
      );
    });
    test('Poulate Blockchain with 10 other addresses', () async {
      for (var i = 0; i < 10; i++) {
        final addPersonResult = await client.sendTransaction(
          credentials,
          Transaction.callContract(
            contract: contract,
            function: addPerson,
            parameters: [EthPrivateKey.createRandom(Random()).address],
          ),
        );

        /// Transaction successful, id: 0x0bf35baf5609fffb740555521a06c2abc7d1324dffe2c02429b1770044759a5e
        print('Transaction successful, id: $addPersonResult');
        expect(addPersonResult, isNotEmpty);
      }
    });

    test('getPeople', () async {
      final getPeopleResult = await client.call(
        contract: contract,
        function: getPeople,
        params: [],
      );

      print('List of all people on the blockchain: ${getPeopleResult.first}');
      expect(getPeopleResult.first, isNotEmpty);

      /// List of all people on the blockchain: [
      ///  0x2ffbdfb832d5295efc087db2e0fd1adeee3439de,
      ///  0x2ffbdfb832d5295efc087db2e0fd1adeee3439de,
      ///  0x2ffbdfb832d5295efc087db2e0fd1adeee3439de
      ///  ]
    });

    test('removePerson', () async {
      final ownAddress = await credentials.extractAddress();
      final removePersonResult = await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: removePerson,
          parameters: [ownAddress],
        ),
      );

      print('Transaction successful, id: $removePersonResult');
      expect(removePersonResult, isNotEmpty);
    });
  });
}
