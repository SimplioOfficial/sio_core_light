import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Address {
  static bool isValid({
    required String address,
    required int networkId,
  }) {
    if (Cluster.ethLegacyAndEIP1559.contains(networkId)) {
      if (address.substring(1, 9).toLowerCase() == 'ethereum:') {
        address = address.substring(10);
      }

      if (address.substring(1, 4).toLowerCase() == 'bnb:') {
        address = address.substring(5);
      }
    }

    if (Cluster.utxo.contains(networkId)) {
      if (address.substring(1, 8) == 'bitcoin:') {
        address = address.substring(9);
      }
    }

    return AnyAddress.isValid(address, networkId);
  }
}
