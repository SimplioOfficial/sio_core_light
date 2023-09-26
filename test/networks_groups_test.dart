import 'package:sio_core_light/sio_core_light.dart';
import 'package:test/test.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('Cluster - ', () {
    test('Cosmos', () {
      expect(Cluster.cosmos, [118, 10000118]);
    });
    test('ethereumLegacy', () {
      expect(Cluster.ethereumLegacy, [61, 20000714]);
    });
    test('ethereumEIP1559', () {
      expect(Cluster.ethereumEIP1559, [10009000, 60, 966]);
    });
    test('Solana', () {
      expect(Cluster.solana, [501]);
    });
    test('Utxo', () {
      expect(Cluster.utxo, [0, 145, 5, 20, 3, 19167, 2, 133]);
    });
  });
  test('EthChainId - ', () {
    expect(EthChainId.avalancheCChain, 43114);
    expect(EthChainId.ethereum, 1);
    expect(EthChainId.ethereumClassic, 61);
    expect(EthChainId.polygon, 137);
    expect(EthChainId.bnbSmartChain, 56);
  });

  test('SioAssetId', () {
    expect(SioAssetId.bitcoin, 1);
    expect(SioAssetId.bnbSmartChain, 7);
    expect(SioAssetId.solana, 3);
  });

  group('EthNetworks - ', () {
    test('chainId', () {
      expect(
        EthNetworks.chainId(networkId: TWCoinType.TWCoinTypeAvalancheCChain),
        EthChainId.avalancheCChain,
      );
      expect(
        EthNetworks.chainId(networkId: TWCoinType.TWCoinTypeEthereum),
        EthChainId.ethereum,
      );
      expect(
        EthNetworks.chainId(networkId: TWCoinType.TWCoinTypeEthereumClassic),
        EthChainId.ethereumClassic,
      );
      expect(
        EthNetworks.chainId(networkId: TWCoinType.TWCoinTypePolygon),
        EthChainId.polygon,
      );
      expect(
        EthNetworks.chainId(networkId: TWCoinType.TWCoinTypeSmartChain),
        EthChainId.bnbSmartChain,
      );

      try {
        EthNetworks.chainId(networkId: 12312312312312);
      } catch (exception) {
        expect(exception, isA<Exception>());
      }
    });
    test('networkId', () {
      expect(
        EthNetworks.networkId(chainId: EthChainId.avalancheCChain),
        TWCoinType.TWCoinTypeAvalancheCChain,
      );
      expect(
        EthNetworks.networkId(chainId: EthChainId.ethereum),
        TWCoinType.TWCoinTypeEthereum,
      );
      expect(
        EthNetworks.networkId(chainId: EthChainId.ethereumClassic),
        TWCoinType.TWCoinTypeEthereumClassic,
      );
      expect(
        EthNetworks.networkId(chainId: EthChainId.polygon),
        TWCoinType.TWCoinTypePolygon,
      );
      expect(
        EthNetworks.networkId(chainId: EthChainId.bnbSmartChain),
        TWCoinType.TWCoinTypeSmartChain,
      );

      try {
        EthNetworks.networkId(chainId: 12312312312312);
      } catch (exception) {
        expect(exception, isA<Exception>());
      }
    });
  });

  group('Networks - ', () {
    test('assetId', () {
      expect(
        Networks.assetId(networkId: TWCoinType.TWCoinTypeBitcoin),
        SioAssetId.bitcoin,
      );
      expect(
        Networks.assetId(networkId: TWCoinType.TWCoinTypeSmartChain),
        SioAssetId.bnbSmartChain,
      );
      expect(
        Networks.assetId(networkId: TWCoinType.TWCoinTypeSolana),
        SioAssetId.solana,
      );

      try {
        Networks.assetId(networkId: 1212312312312123123);
      } catch (exception) {
        expect(exception, isA<Exception>());
      }
    });
    test('assetId', () {
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeCosmos),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeAvalancheCChain),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeBitcoinCash),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeSmartChain),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeBitcoin),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeDash),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeDigiByte),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeDogecoin),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeEthereumClassic),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeEthereum),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeZelcash),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeLitecoin),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeOsmosis),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypePolygon),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeSolana),
        true,
      );
      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeZcash),
        true,
      );

      expect(
        Networks.isSupported(networkId: TWCoinType.TWCoinTypeSmartChainLegacy),
        false,
      );
    });
  });
}
