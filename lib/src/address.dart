import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Address {
  static bool isValid({
    required String address,
    required int networkId,
  }) {
    return AnyAddress.isValid(address, networkId);
  }

  static String parse({
    required String address,
    required int networkId,
  }) {
    if (address.length < 10) return address;

    if (Cluster.ethLegacyAndEIP1559.contains(networkId)) {
      if (address.substring(0, 9).toLowerCase() == 'ethereum:') {
        address = address.substring(9);
      }

      if (address.substring(0, 4).toLowerCase() == 'bnb:') {
        address = address.substring(4);
      }
    }

    if (Cluster.utxo.contains(networkId)) {
      if (address.substring(0, 8) == 'bitcoin:') {
        address = address.substring(8);
      }
    }

    return address;
  }
}
