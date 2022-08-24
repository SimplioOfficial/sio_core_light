import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

const List<int> cosmosGroup = [
  TWCoinType.TWCoinTypeCosmos,
  TWCoinType.TWCoinTypeOsmosis,
];

const List<int> ethereumLegacyGroup = [
  TWCoinType.TWCoinTypeEthereumClassic,
  TWCoinType.TWCoinTypeSmartChain,
];

const List<int> ethereumEIP1559Group = [
  TWCoinType.TWCoinTypeAvalancheCChain,
  TWCoinType.TWCoinTypeEthereum,
  TWCoinType.TWCoinTypePolygon
];

const List<int> solanaGroup = [
  TWCoinType.TWCoinTypeSolana,
];

const List<int> utxoGroup = [
  TWCoinType.TWCoinTypeBitcoin,
  TWCoinType.TWCoinTypeBitcoinCash,
  TWCoinType.TWCoinTypeDash,
  TWCoinType.TWCoinTypeDigiByte,
  TWCoinType.TWCoinTypeDogecoin,
  TWCoinType.TWCoinTypeZelcash, // This is Flux
  TWCoinType.TWCoinTypeLitecoin,
  TWCoinType.TWCoinTypeZcash,
];

class EthereumNetworks {
  static int chainId({
    required int networkId,
  }) {
    if (networkId == TWCoinType.TWCoinTypeAvalancheCChain) return 43114;
    if (networkId == TWCoinType.TWCoinTypeEthereum) return 1;
    if (networkId == TWCoinType.TWCoinTypeEthereumClassic) return 61;
    if (networkId == TWCoinType.TWCoinTypePolygon) return 137;
    if (networkId == TWCoinType.TWCoinTypeSmartChain) return 56;
    throw Exception('networkId is not supported');
  }
}
