import 'package:collection/collection.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

const Map<String, List<int>> prefixToNetworkId = {
  'ethereum': Cluster.ethLegacyAndEIP1559,
  'bnb': [TWCoinType.TWCoinTypeSmartChain],
  'bitcoin': Cluster.utxo,
};

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
    final addressLowercase = address.toLowerCase();
    final usedPrefix = prefixToNetworkId.keys
        .firstWhereOrNull((prefix) => addressLowercase.startsWith('$prefix:'));
    if (usedPrefix != null &&
        (prefixToNetworkId[usedPrefix]?.contains(networkId) ?? false)) {
      address = address.replaceFirst(
        RegExp('$usedPrefix:', caseSensitive: false),
        '',
      );
    }

    return address;
  }
}
