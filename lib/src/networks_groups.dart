import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

class Cluster {
  static const List<int> cosmos = [
    TWCoinType.TWCoinTypeCosmos,
    TWCoinType.TWCoinTypeOsmosis,
  ];
  static const List<int> ethereumLegacy = [
    TWCoinType.TWCoinTypeEthereumClassic,
    TWCoinType.TWCoinTypeSmartChain,
  ];
  static const List<int> ethereumEIP1559 = [
    TWCoinType.TWCoinTypeAvalancheCChain,
    TWCoinType.TWCoinTypeEthereum,
    TWCoinType.TWCoinTypePolygon
  ];
  static const List<int> solana = [
    TWCoinType.TWCoinTypeSolana,
  ];
  static const List<int> utxoGroup = [
    TWCoinType.TWCoinTypeBitcoin,
    TWCoinType.TWCoinTypeBitcoinCash,
    TWCoinType.TWCoinTypeDash,
    TWCoinType.TWCoinTypeDigiByte,
    TWCoinType.TWCoinTypeDogecoin,
    TWCoinType.TWCoinTypeZelcash, // This is Flux
    TWCoinType.TWCoinTypeLitecoin,
    TWCoinType.TWCoinTypeZcash,
  ];
}

// Ethereum networks chain IDs
class EthChainId {
  static const avalancheCChain = 43114;
  static const ethereum = 1;
  static const ethereumClassic = 61;
  static const polygon = 137;
  static const bnbSmartChain = 56;
}

/// Simplio asset IDs of the native cryptocurrency for each supported network.
class SioAssetId {
  static const bitcoin = 1;
  static const bnbSmartChain = 7;
}

class EthNetworks {
  /// Returns the Ethereum chain ID from the network ID
  /// (Coin type for Level 2 of BIP44).
  ///
  /// - SeeAlso: https://github.com/satoshilabs/slips/blob/master/slip-0044.md
  static int chainId({
    required int networkId,
  }) {
    switch (networkId) {
      case TWCoinType.TWCoinTypeAvalancheCChain:
        return EthChainId.avalancheCChain;
      case TWCoinType.TWCoinTypeEthereum:
        return EthChainId.ethereum;
      case TWCoinType.TWCoinTypeEthereumClassic:
        return EthChainId.ethereumClassic;
      case TWCoinType.TWCoinTypePolygon:
        return EthChainId.polygon;
      case TWCoinType.TWCoinTypeSmartChain:
        return EthChainId.bnbSmartChain;

      default:
        throw Exception('Network ID is not supported');
    }
  }

  /// Returns the network ID (Coin type for Level 2 of BIP44)
  /// from the Ethereum chain ID.
  ///
  /// - SeeAlso: https://github.com/satoshilabs/slips/blob/master/slip-0044.md
  static int networkId({
    required int chainId,
  }) {
    switch (chainId) {
      case EthChainId.avalancheCChain:
        return TWCoinType.TWCoinTypeAvalancheCChain;
      case EthChainId.ethereum:
        return TWCoinType.TWCoinTypeEthereum;
      case EthChainId.ethereumClassic:
        return TWCoinType.TWCoinTypeEthereumClassic;
      case EthChainId.polygon:
        return TWCoinType.TWCoinTypePolygon;
      case EthChainId.bnbSmartChain:
        return TWCoinType.TWCoinTypeSmartChain;

      default:
        throw Exception('Chain ID is not supported');
    }
  }
}

class Networks {
  /// Returns the Simplio asset ID of the native cryptocurrency for each
  /// supported network from the network ID (Coin type for Level 2 of BIP44).
  ///
  /// - SeeAlso: https://github.com/satoshilabs/slips/blob/master/slip-0044.md
  static int assetId({
    required int networkId,
  }) {
    switch (networkId) {
      case TWCoinType.TWCoinTypeBitcoin:
        return SioAssetId.bitcoin;
      case TWCoinType.TWCoinTypeSmartChain:
        return SioAssetId.bnbSmartChain;

      default:
        throw Exception('Network ID is not supported');
    }
  }
}
