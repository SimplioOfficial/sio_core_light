import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class EthSign {
  static String typedData({
    required HDWallet wallet,
    required int networkId,
    required String jsonData,
    TypedDataVersion version = TypedDataVersion.V4,
  }) {
    return EthSigUtil.signTypedData(
        privateKeyInBytes: wallet.getKeyForCoin(networkId).data(),
        jsonData: jsonData,
        version: version);
  }

  static String personalTypedData({
    required HDWallet wallet,
    required int networkId,
    required String jsonData,
    TypedDataVersion version = TypedDataVersion.V4,
  }) {
    return EthSigUtil.signPersonalTypedData(
      privateKeyInBytes: wallet.getKeyForCoin(networkId).data(),
      jsonData: jsonData,
      version: version,
    );
  }

  static String message({
    required HDWallet wallet,
    required int networkId,
    required Uint8List message,
  }) {
    return EthSigUtil.signMessage(
      privateKeyInBytes: wallet.getKeyForCoin(networkId).data(),
      message: message,
    );
  }

  static String personalMessage({
    required HDWallet wallet,
    required int networkId,
    required Uint8List message,
  }) {
    return EthSigUtil.signPersonalMessage(
      privateKeyInBytes: wallet.getKeyForCoin(networkId).data(),
      message: message,
    );
  }
}
