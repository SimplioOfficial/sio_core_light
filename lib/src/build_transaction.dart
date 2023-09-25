import 'package:convert/convert.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/protobuf/Bitcoin.pb.dart' as bitcoin_pb;
import 'package:trust_wallet_core_lib/protobuf/Cosmos.pb.dart' as cosmos_pb;
import 'package:trust_wallet_core_lib/protobuf/Ethereum.pb.dart' as ethereum_pb;
import 'package:trust_wallet_core_lib/protobuf/Solana.pb.dart' as solana_pb;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Transaction {
  final String rawTx;
  final BigInt networkFee;

  Transaction({
    required this.rawTx,
    required this.networkFee,
  });

  Map<String, dynamic> toJson() {
    return {
      'txid': rawTx,
      'networkFee': networkFee.toString(),
    };
  }
}

/// Class that builds transactions and return OutputTx ready for broadcasting.
class BuildTransaction {
  /// Cosmos native transactions.
  ///
  /// Denomination of OSMO: `uosmo`, `mosmo`, `osmo`.
  ///
  /// ChainId of OSMO: `osmosis-1`.
  ///
  /// BroadcastMode enum: `0-BLOCK`, `1-SYNC`, `2-ASYNC`.
  static Transaction cosmos({
    required HDWallet wallet,
    required int coin,
    required String amount,
    required String toAddress,
    required String chainId,
    required String denomination,
    required String accountNumber,
    required String sequence,
    String fee = '0',
    String gas = '200000',
    int broadcastMode = 0,
  }) {
    final messageSend = cosmos_pb.Message_Send(
      amounts: [
        cosmos_pb.Amount(
          amount: amount,
          denom: denomination,
        )
      ],
      fromAddress: wallet.getAddressForCoin(coin),
      toAddress: toAddress,
    );
    final signingInput = cosmos_pb.SigningInput(
      signingMode: cosmos_pb.SigningMode.Protobuf,
      chainId: chainId,
      messages: [cosmos_pb.Message(sendCoinsMessage: messageSend)],
      fee: cosmos_pb.Fee(
        amounts: [
          cosmos_pb.Amount(
            amount: fee,
            denom: denomination,
          )
        ],
        gas: $fixnum.Int64.parseInt(gas),
      ),
      privateKey: wallet.getKeyForCoin(coin).data(),
      memo: '',
      accountNumber: $fixnum.Int64.parseInt(accountNumber),
      sequence: $fixnum.Int64.parseInt(sequence),
      mode: cosmos_pb.BroadcastMode.valueOf(broadcastMode),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coin);
    final signingOutput = cosmos_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: signingOutput.serialized,
      networkFee: BigInt.parse(fee),
    );
    return transaction;
  }

  /// Ethereum native transactions.
  /// EIP-1559 type transaction.
  ///
  /// Works with AVAX, ETH, MATIC
  ///
  /// * `amount` value in wei.
  /// * `maxInclusionFeePerGas`, `maxFeePerGas`  and `gasLimit` values in wei.
  /// * `maxInclusionFeePerGas` = `Max Priority Fee Per Gas`
  /// * `maxFeePerGas` = `Base Fee Per Gas` + `Max Priority Fee Per Gas`
  ///
  /// ChainIds for mainnet:
  /// * AVAX = 43114
  /// * ETH = 1
  /// * MATIC = 137
  static Transaction ethereumEIP1559({
    required HDWallet wallet,
    // value in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt amount,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) ETH (or 10^(-9) gwei)
    String maxInclusionFeePerGas = '2000000000',
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt maxFeePerGas,
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt gasLimit,
    int chainId = 1,
    int coinType = TWCoinType.TWCoinTypeEthereum,
    String? data,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);
    final tx = ethereum_pb.Transaction_Transfer(
      amount: bigIntToBytes(amount),
      data: data == null ? null : hex.decode(data.substring(2)),
    );
    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      txMode: ethereum_pb.TransactionMode.Enveloped,
      maxInclusionFeePerGas: bigIntToBytes(BigInt.parse(maxInclusionFeePerGas)),
      maxFeePerGas: bigIntToBytes(maxFeePerGas),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: toAddress,
      transaction: ethereum_pb.Transaction(transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: maxFeePerGas * gasLimit,
    );
    return transaction;
  }

  /// Ethereum ERC20 token transactions.
  /// EIP-1559 type transaction.
  ///
  /// Works with AVAX, ETH, MATIC
  ///
  /// * `amount` value in smallest denomination.
  /// * `maxInclusionFeePerGas`, `maxFeePerGas`  and `gasLimit` values in wei.
  /// * `maxInclusionFeePerGas` = `Max Priority Fee Per Gas`
  /// * `maxFeePerGas` = `Base Fee Per Gas` + `Max Priority Fee Per Gas`
  ///
  /// ChainIds for mainnet:
  /// * AVAX = 43114
  /// * ETH = 1
  /// * MATIC = 137
  static Transaction ethereumERC20TokenEIP1559({
    required HDWallet wallet,
    // value in smallest denomination
    required BigInt amount,
    required String tokenContract,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) ETH (or 10^(-9) gwei)
    String maxInclusionFeePerGas = '2000000000',
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt maxFeePerGas,
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt gasLimit,
    int chainId = 1,
    int coinType = TWCoinType.TWCoinTypeEthereum,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);

    final tx = ethereum_pb.Transaction_ERC20Transfer(
      amount: bigIntToBytes(amount),
      to: toAddress,
    );

    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      txMode: ethereum_pb.TransactionMode.Enveloped,
      maxInclusionFeePerGas: bigIntToBytes(BigInt.parse(maxInclusionFeePerGas)),
      maxFeePerGas: bigIntToBytes(maxFeePerGas),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: tokenContract,
      transaction: ethereum_pb.Transaction(erc20Transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: maxFeePerGas * gasLimit,
    );
    return transaction;
  }

  /// Ethereum ERC1155 token transactions.
  /// EIP-1559 type transaction.
  ///
  /// Works with AVAX, ETH, MATIC
  ///
  /// * `amount` value in smallest denomination.
  /// * `maxInclusionFeePerGas`, `maxFeePerGas`  and `gasLimit` values in wei.
  /// * `maxInclusionFeePerGas` = `Max Priority Fee Per Gas`
  /// * `maxFeePerGas` = `Base Fee Per Gas` + `Max Priority Fee Per Gas`
  ///
  /// ChainIds for mainnet:
  /// * AVAX = 43114
  /// * ETH = 1
  /// * MATIC = 137
  static Transaction ethereumERC1155TokenEIP1559({
    required HDWallet wallet,
    // value in smallest denomination
    required BigInt amount,
    required String tokenContract,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) ETH (or 10^(-9) gwei)
    String maxInclusionFeePerGas = '2000000000',
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt maxFeePerGas,
    // price in wei = 10^(-18) ETH (or 10^(-9) gwei)
    required BigInt gasLimit,
    required int tokenId,
    int chainId = 1,
    int coinType = TWCoinType.TWCoinTypeEthereum,
    String? data,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);

    final tx = ethereum_pb.Transaction_ERC1155Transfer(
      from: wallet.getAddressForCoin(coinType),
      to: toAddress,
      tokenId: bigIntToBytes(BigInt.from(tokenId)),
      value: bigIntToBytes(amount),
      data: data == null ? null : hex.decode(data.substring(2)),
    );

    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      txMode: ethereum_pb.TransactionMode.Enveloped,
      maxInclusionFeePerGas: bigIntToBytes(BigInt.parse(maxInclusionFeePerGas)),
      maxFeePerGas: bigIntToBytes(maxFeePerGas),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: tokenContract,
      transaction: ethereum_pb.Transaction(erc1155Transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: maxFeePerGas * gasLimit,
    );
    return transaction;
  }

  /// Ethereum native transactions.
  /// Legacy type transaction.
  ///
  /// Works with BSC, ETC
  ///
  /// * `amount` value in wei.
  /// * `gasPrice` and `gasLimit` values in wei.
  ///
  /// ChainIds for mainnet:
  /// * BSC = 56
  /// * ETC = 61
  static Transaction ethereumLegacy({
    required HDWallet wallet,
    // value in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt amount,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasPrice,
    // price in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasLimit,
    int chainId = 56,
    int coinType = TWCoinType.TWCoinTypeSmartChain,
    String? data,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);
    final tx = ethereum_pb.Transaction_Transfer(
      amount: bigIntToBytes(amount),
      data: data == null ? null : hex.decode(data.substring(2)),
    );
    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      gasPrice: bigIntToBytes(gasPrice),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: toAddress,
      transaction: ethereum_pb.Transaction(transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: gasPrice * gasLimit,
    );
    return transaction;
  }

  /// Ethereum ERC20 token transactions.
  /// Legacy type transaction.
  ///
  /// Works with BSC, ETC
  ///
  /// * `amount` value in smallest denomination.
  /// * `gasPrice` and `gasLimit` values in wei.
  ///
  /// ChainIds for mainnet:
  /// * BSC = 56
  /// * ETC = 61
  static Transaction ethereumERC20TokenLegacy({
    required HDWallet wallet,
    // value in smallest denomination
    required BigInt amount,
    required String tokenContract,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasPrice,
    // price in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasLimit,
    int chainId = 56,
    int coinType = TWCoinType.TWCoinTypeSmartChain,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);

    final tx = ethereum_pb.Transaction_ERC20Transfer(
      amount: bigIntToBytes(amount),
      to: toAddress,
    );

    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      gasPrice: bigIntToBytes(gasPrice),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: tokenContract,
      transaction: ethereum_pb.Transaction(erc20Transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: gasPrice * gasLimit,
    );
    return transaction;
  }

  /// Ethereum ERC1155 token transactions.
  /// Legacy type transaction.
  ///
  /// Works with BSC, ETC
  ///
  /// * `amount` value in smallest denomination.
  /// * `gasPrice` and `gasLimit` values in wei.
  ///
  /// ChainIds for mainnet:
  /// * BSC = 56
  /// * ETC = 61
  static Transaction ethereumERC1155TokenLegacy({
    required HDWallet wallet,
    // value in smallest denomination
    required BigInt amount,
    required String tokenContract,
    required String toAddress,
    required int nonce,
    // value in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasPrice,
    // price in wei = 10^(-18) BNB (or 10^(-9) gwei)
    required BigInt gasLimit,
    required int tokenId,
    int chainId = 56,
    int coinType = TWCoinType.TWCoinTypeSmartChain,
    String? data,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(coinType);

    final tx = ethereum_pb.Transaction_ERC1155Transfer(
      from: wallet.getAddressForCoin(coinType),
      to: toAddress,
      tokenId: bigIntToBytes(BigInt.from(tokenId)),
      value: bigIntToBytes(amount),
      data: data == null ? null : hex.decode(data.substring(2)),
    );

    final signingInput = ethereum_pb.SigningInput(
      chainId: bigIntToBytes(BigInt.from(chainId)),
      gasPrice: bigIntToBytes(gasPrice),
      gasLimit: bigIntToBytes(gasLimit),
      toAddress: tokenContract,
      transaction: ethereum_pb.Transaction(erc1155Transfer: tx),
      privateKey: secretPrivateKey.data(),
      nonce: bigIntToBytes(BigInt.from(nonce)),
    );
    final sign = AnySigner.sign(signingInput.writeToBuffer(), coinType);
    final signingOutput = ethereum_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: gasPrice * gasLimit,
    );
    return transaction;
  }

  /// Solana native transaction.
  ///
  /// * `amount` and `fee` values in lamports.
  static Transaction solana({
    required HDWallet wallet,
    required String recipient,
    required BigInt amount,
    required String latestBlockHash,
    required BigInt fee,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(TWCoinType.TWCoinTypeSolana);

    final tx = solana_pb.Transfer(
      recipient: recipient,
      value: $fixnum.Int64.parseInt(amount.toString()),
    );
    final signingInput = solana_pb.SigningInput(
      privateKey: secretPrivateKey.data().toList(),
      recentBlockhash: latestBlockHash,
      transferTransaction: tx,
    );
    final sign = AnySigner.sign(
      signingInput.writeToBuffer(),
      TWCoinType.TWCoinTypeSolana,
    );
    final signingOutput = solana_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: signingOutput.encoded,
      networkFee: fee,
    );
    return transaction;
  }

  /// Solana token transaction.
  ///
  /// * `amount` value in smallest denomination.
  /// * `fee` value in lamports.
  static Transaction solanaToken({
    required HDWallet wallet,
    required String recipientSolanaAddress,
    required String tokenMintAddress,
    required BigInt amount,
    required int decimals,
    required String latestBlockHash,
    required BigInt fee,
  }) {
    final secretPrivateKey = wallet.getKeyForCoin(TWCoinType.TWCoinTypeSolana);

    final solanaAddress = SolanaAddress.createWithString(
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana));
    final senderTokenAddress =
        solanaAddress.defaultTokenAddress(tokenMintAddress);

    final recipientTokenAddress =
        SolanaAddress.createWithString(recipientSolanaAddress)
            .defaultTokenAddress(tokenMintAddress);
    final tx = solana_pb.TokenTransfer(
      tokenMintAddress: tokenMintAddress,
      senderTokenAddress: senderTokenAddress,
      recipientTokenAddress: recipientTokenAddress,
      amount: $fixnum.Int64.parseInt(amount.toString()),
      decimals: decimals,
    );

    final signingInput = solana_pb.SigningInput(
      privateKey: secretPrivateKey.data().toList(),
      recentBlockhash: latestBlockHash,
      tokenTransferTransaction: tx,
    );
    final sign = AnySigner.sign(
      signingInput.writeToBuffer(),
      TWCoinType.TWCoinTypeSolana,
    );
    final signingOutput = solana_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: signingOutput.encoded,
      networkFee: fee,
    );
    return transaction;
  }

  /// Utxo coins transaction.
  static Transaction utxoCoin({
    required HDWallet wallet,
    required int coin,
    required String toAddress,
    required BigInt amount,
    required BigInt byteFee,
    required List<dynamic> utxo,
  }) {
    final changeAddress = wallet.getAddressForCoin(coin);

    utxo.sort(
      (map1, map2) => map1['value'] != null
          ? int.parse(map1['value'] as String)
              .compareTo(int.parse(map2['value'] as String))
          : (map1['satoshis'] as int).compareTo(map2['satoshis'] as int),
    );

    var minUtxoNeed = 0;
    var minUtxoAmountNeed = BigInt.zero;
    for (final tx in utxo) {
      if (minUtxoAmountNeed < amount) {
        minUtxoNeed++;
        minUtxoAmountNeed += tx['value'] != null
            ? BigInt.parse(tx['value'] as String)
            : BigInt.from(tx['satoshis'] as int);
      } else {
        break;
      }
    }
    final minUtxo = utxo.take(minUtxoNeed).toList();

    final utxoParsed = <bitcoin_pb.UnspentTransaction>[];
    for (var index = 0; index < minUtxo.length; index++) {
      final txParsed = bitcoin_pb.UnspentTransaction(
        amount: minUtxo[index]['value'] != null
            ? $fixnum.Int64.parseInt(minUtxo[index]['value'] as String)
            : $fixnum.Int64(minUtxo[index]['satoshis'] as int),
        outPoint: bitcoin_pb.OutPoint(
          hash: hex.decode(minUtxo[index]['txid'] as String).reversed.toList(),
          index: minUtxo[index]['vout'] as int,
        ),
        script: BitcoinScript.lockScriptForAddress(
                wallet.getAddressForCoin(coin), coin)
            .data()
            .toList(),
      );
      utxoParsed.add(txParsed);
    }

    var signingInput = bitcoin_pb.SigningInput(
      amount: $fixnum.Int64.parseInt(amount.toString()),
      hashType: BitcoinScript.hashTypeForCoin(coin),
      toAddress: toAddress,
      changeAddress: changeAddress,
      byteFee: $fixnum.Int64.parseInt(byteFee.toString()),
      coinType: coin,
      utxo: utxoParsed,
      privateKey: [wallet.getKeyForCoin(coin).data().toList()],
    );
    var transactionPlan = bitcoin_pb.TransactionPlan.fromBuffer(
      AnySigner.signerPlan(signingInput.writeToBuffer(), coin).toList(),
    );

    while ((amount + BigInt.parse(transactionPlan.fee.toString()) >
                minUtxoAmountNeed ||
            transactionPlan.fee.toInt() == 0) &&
        minUtxoNeed < utxo.length) {
      final txParsed = bitcoin_pb.UnspentTransaction(
        amount: utxo[minUtxoNeed]['value'] != null
            ? $fixnum.Int64.parseInt(utxo[minUtxoNeed]['value'] as String)
            : $fixnum.Int64(utxo[minUtxoNeed]['satoshis'] as int),
        outPoint: bitcoin_pb.OutPoint(
          hash:
              hex.decode(utxo[minUtxoNeed]['txid'] as String).reversed.toList(),
          index: utxo[minUtxoNeed]['vout'] as int,
        ),
        script: BitcoinScript.lockScriptForAddress(
                wallet.getAddressForCoin(coin), coin)
            .data()
            .toList(),
      );
      utxoParsed.add(txParsed);
      minUtxoAmountNeed += utxo[minUtxoNeed]['value'] != null
          ? BigInt.parse(utxo[minUtxoNeed]['value'] as String)
          : BigInt.from(utxo[minUtxoNeed]['satoshis'] as int);
      minUtxoNeed++;
      signingInput = bitcoin_pb.SigningInput(
        amount: $fixnum.Int64.parseInt(amount.toString()),
        hashType: BitcoinScript.hashTypeForCoin(coin),
        toAddress: toAddress,
        changeAddress: changeAddress,
        byteFee: $fixnum.Int64.parseInt(byteFee.toString()),
        coinType: coin,
        utxo: utxoParsed,
        privateKey: [wallet.getKeyForCoin(coin).data().toList()],
      );
      transactionPlan = bitcoin_pb.TransactionPlan.fromBuffer(
        AnySigner.signerPlan(signingInput.writeToBuffer(), coin).toList(),
      );
    }

    signingInput
      ..plan = transactionPlan
      ..amount = transactionPlan.amount;

    final sign = AnySigner.sign(signingInput.writeToBuffer(), coin);
    final signingOutput = bitcoin_pb.SigningOutput.fromBuffer(sign);
    final inputs = minUtxoNeed;
    final outputs = amount == minUtxoAmountNeed ? 1 : 2;
    final networkFee = transactionPlan.fee.toInt() == 0
        ? BigInt.zero
        : feeCalculator(inputs, outputs, byteFee, coin);

    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: networkFee,
    );
    return transaction;
  }

  /// Utxo coins transaction that handles exceptions.
  static Transaction utxoCoinWithExceptionHandling({
    required HDWallet wallet,
    required int coin,
    required String toAddress,
    required BigInt amount,
    required BigInt byteFee,
    required List<dynamic> utxo,
  }) {
    final changeAddress = wallet.getAddressForCoin(coin);
    if (utxo.isEmpty) {
      throw const NoUtxoAvailableException();
    }
    utxo.sort(
      (map1, map2) => map1['value'] != null
          ? int.parse(map1['value'] as String)
              .compareTo(int.parse(map2['value'] as String))
          : (map1['satoshis'] as int).compareTo(map2['satoshis'] as int),
    );

    var minUtxoNeed = 0;
    var minUtxoAmountNeed = BigInt.zero;
    for (final tx in utxo) {
      if (minUtxoAmountNeed < amount) {
        minUtxoNeed++;
        minUtxoAmountNeed += tx['value'] != null
            ? BigInt.parse(tx['value'] as String)
            : BigInt.from(tx['satoshis'] as int);
      } else {
        break;
      }
    }
    final minUtxo = utxo.take(minUtxoNeed).toList();

    final utxoParsed = <bitcoin_pb.UnspentTransaction>[];
    for (var index = 0; index < minUtxo.length; index++) {
      final txParsed = bitcoin_pb.UnspentTransaction(
        amount: minUtxo[index]['value'] != null
            ? $fixnum.Int64.parseInt(minUtxo[index]['value'] as String)
            : $fixnum.Int64(minUtxo[index]['satoshis'] as int),
        outPoint: bitcoin_pb.OutPoint(
          hash: hex.decode(minUtxo[index]['txid'] as String).reversed.toList(),
          index: minUtxo[index]['vout'] as int,
        ),
        script: BitcoinScript.lockScriptForAddress(
                wallet.getAddressForCoin(coin), coin)
            .data()
            .toList(),
      );
      utxoParsed.add(txParsed);
    }

    var signingInput = bitcoin_pb.SigningInput(
      amount: $fixnum.Int64.parseInt(amount.toString()),
      hashType: BitcoinScript.hashTypeForCoin(coin),
      toAddress: toAddress,
      changeAddress: changeAddress,
      byteFee: $fixnum.Int64.parseInt(byteFee.toString()),
      coinType: coin,
      utxo: utxoParsed,
      privateKey: [wallet.getKeyForCoin(coin).data().toList()],
    );
    var transactionPlan = bitcoin_pb.TransactionPlan.fromBuffer(
      AnySigner.signerPlan(signingInput.writeToBuffer(), coin).toList(),
    );

    while ((amount + BigInt.parse(transactionPlan.fee.toString()) >
                minUtxoAmountNeed ||
            transactionPlan.fee.toInt() == 0) &&
        minUtxoNeed < utxo.length) {
      final txParsed = bitcoin_pb.UnspentTransaction(
        amount: utxo[minUtxoNeed]['value'] != null
            ? $fixnum.Int64.parseInt(utxo[minUtxoNeed]['value'] as String)
            : $fixnum.Int64(utxo[minUtxoNeed]['satoshis'] as int),
        outPoint: bitcoin_pb.OutPoint(
          hash:
              hex.decode(utxo[minUtxoNeed]['txid'] as String).reversed.toList(),
          index: utxo[minUtxoNeed]['vout'] as int,
        ),
        script: BitcoinScript.lockScriptForAddress(
                wallet.getAddressForCoin(coin), coin)
            .data()
            .toList(),
      );
      utxoParsed.add(txParsed);
      minUtxoAmountNeed += utxo[minUtxoNeed]['value'] != null
          ? BigInt.parse(utxo[minUtxoNeed]['value'] as String)
          : BigInt.from(utxo[minUtxoNeed]['satoshis'] as int);
      minUtxoNeed++;
      signingInput = bitcoin_pb.SigningInput(
        amount: $fixnum.Int64.parseInt(amount.toString()),
        hashType: BitcoinScript.hashTypeForCoin(coin),
        toAddress: toAddress,
        changeAddress: changeAddress,
        byteFee: $fixnum.Int64.parseInt(byteFee.toString()),
        coinType: coin,
        utxo: utxoParsed,
        privateKey: [wallet.getKeyForCoin(coin).data().toList()],
      );
      transactionPlan = bitcoin_pb.TransactionPlan.fromBuffer(
        AnySigner.signerPlan(signingInput.writeToBuffer(), coin).toList(),
      );
    }

    if (minUtxoNeed == utxo.length && transactionPlan.fee.toInt() == 0) {
      throw const LowTotalAmountPlusFeeException();
    }

    signingInput
      ..plan = transactionPlan
      ..amount = transactionPlan.amount;

    final sign = AnySigner.sign(signingInput.writeToBuffer(), coin);
    final signingOutput = bitcoin_pb.SigningOutput.fromBuffer(sign);
    final transaction = Transaction(
      rawTx: hex.encode(signingOutput.encoded),
      networkFee: BigInt.parse(transactionPlan.fee.toString()),
    );
    return transaction;
  }
}
