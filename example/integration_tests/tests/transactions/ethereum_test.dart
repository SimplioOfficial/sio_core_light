import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;

void main() {
  trust_core.HDWallet wallet;

  const mnemonic = 'horror select baby exile convince sunset outside vehicle write decade powder energy';

  if (Mnemonic.isValid(mnemonic: mnemonic)) {
    wallet = Mnemonic.import(mnemonic: mnemonic);
  } else {
    throw Exception(['Mnemonic is not valid!']);
  }

  group('Ethereum - ', () {
    const toAddress = '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47';
    final amount = BigInt.from(924400);
    final gasLimit = BigInt.from(21000);
    const tokenContract = '0x26Fc591feCC4948c4288d95B6AAdAB00eBa4e72A';
    test('BSC native transaction', () {
      final gasPrice = BigInt.from(13600000000);
      final signedBscTx = BuildTransaction.ethereumLegacy(
        wallet: wallet,
        amount: amount,
        toAddress: toAddress,
        nonce: 0,
        gasPrice: gasPrice,
        gasLimit: gasLimit,
      );
      expect(hex.decode(signedBscTx.rawTx).length, 106);
      expect(signedBscTx.toJson(), {
        'txid':
            'f8688085032a9f8800825208943e26e7f73a80444e67b7be654a38ab85ccb6ea47830e1af0808194a04e896890d73533b7ac0003e9e18c1ee8913d57df57eec292f84241d21d1a94bba0027aac3d1a1523d56131587c1e4ce422504507caac8d3252dfe72263da94a415',
        'networkFee': '285600000000000'
      });
    });
    test('BSC token transaction', () {
      final gasPrice = BigInt.from(3600000000);
      final signedBscTx = BuildTransaction.ethereumERC20TokenLegacy(
        wallet: wallet,
        amount: amount,
        tokenContract: tokenContract,
        toAddress: toAddress,
        nonce: 0,
        gasPrice: gasPrice,
        gasLimit: gasLimit,
      );
      expect(hex.decode(signedBscTx.rawTx).length, 171);
      expect(signedBscTx.toJson(), {
        'txid':
            'f8a98084d693a4008252089426fc591fecc4948c4288d95b6aadab00eba4e72a80b844a9059cbb0000000000000000000000003e26e7f73a80444e67b7be654a38ab85ccb6ea4700000000000000000000000000000000000000000000000000000000000e1af08194a0cad73e551edf5e537ee7bad6cdf3e5454c70566b6ea7471b4df4360c364087afa02cfcc1d078171ebc87fc36b725d50f172d9414e50c15c87f59508101b8ae40ea',
        'networkFee': '75600000000000'
      });
    });
    test('Ethereum native transaction', () {
      final gasPrice = BigInt.from(70000000000);
      final signedEthTx = BuildTransaction.ethereumEIP1559(
        wallet: wallet,
        amount: amount,
        toAddress: toAddress,
        nonce: 0,
        maxFeePerGas: gasPrice,
        gasLimit: gasLimit,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 113);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f86e0180847735940085104c533c00825208943e26e7f73a80444e67b7be654a38ab85ccb6ea47830e1af080c001a0651b21fd30b7289fe8cd9a9ff7835ddc7d9941ae137610b00d1ef308a90cf0a3a006e633b21ebc95ad941f6450cd9b990b5ee8f79bc1631245ee934ff4ae1e9a9d',
        'networkFee': '1470000000000000'
      });
    });
    test('Ethereum ERC20 token transaction', () {
      final gasPrice = BigInt.from(70000000000);
      final signedEthTx = BuildTransaction.ethereumERC20TokenEIP1559(
        wallet: wallet,
        amount: amount,
        tokenContract: tokenContract,
        toAddress: toAddress,
        nonce: 0,
        maxFeePerGas: gasPrice,
        gasLimit: gasLimit,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 178);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f8af0180847735940085104c533c008252089426fc591fecc4948c4288d95b6aadab00eba4e72a80b844a9059cbb0000000000000000000000003e26e7f73a80444e67b7be654a38ab85ccb6ea4700000000000000000000000000000000000000000000000000000000000e1af0c0019f167aba1c67d36ff746999a00c1e63925bb3d742e1ea2011ad9daa24bcf400ba059efe11b45173f678264e72b89efa480500aa4e4c8cce18a25c6897e96a25732',
        'networkFee': '1470000000000000'
      });
    });
    test('Ethereum Classic native transaction', () {
      final gasPrice = BigInt.from(5000000000);
      final signedEtcTx = BuildTransaction.ethereumLegacy(
        wallet: wallet,
        amount: amount,
        toAddress: toAddress,
        nonce: 0,
        gasPrice: gasPrice,
        gasLimit: gasLimit,
        chainId: 61,
        coinType: TWCoinType.TWCoinTypeEthereumClassic,
      );
      expect(hex.decode(signedEtcTx.rawTx).length, 106);
      expect(signedEtcTx.toJson(), {
        'txid':
            'f8688085012a05f200825208943e26e7f73a80444e67b7be654a38ab85ccb6ea47830e1af080819ea0b8a46cdf4863ad0e2fef5613e678f6ec0b846027782a4d7e41761ab1391369dfa048f37362856123a41d9a80b505b35f47fff4e08e1142f792336ee478656e834c',
        'networkFee': '105000000000000'
      });
    });
    test('Ethereum Classic ETC20 token transaction', () {
      final gasPrice = BigInt.from(5000000000);
      final signedBscTx = BuildTransaction.ethereumERC20TokenLegacy(
        wallet: wallet,
        amount: amount,
        tokenContract: tokenContract,
        toAddress: toAddress,
        nonce: 0,
        gasPrice: gasPrice,
        gasLimit: gasLimit,
        chainId: 61,
        coinType: TWCoinType.TWCoinTypeEthereumClassic,
      );
      expect(hex.decode(signedBscTx.rawTx).length, 172);
      expect(signedBscTx.toJson(), {
        'txid':
            'f8aa8085012a05f2008252089426fc591fecc4948c4288d95b6aadab00eba4e72a80b844a9059cbb0000000000000000000000003e26e7f73a80444e67b7be654a38ab85ccb6ea4700000000000000000000000000000000000000000000000000000000000e1af0819da0f70a466dd155e27fe815c1782cf8425161aabbdbe0c3019fa502b25558624ccfa077f19ea31dee23f491d9b21ee540ab113e4cafd85aa40f8fda013fa733121acf',
        'networkFee': '105000000000000'
      });
    });
    test('Polygon native transaction', () {
      final gasPrice = BigInt.from(40000000000);
      final signedEthTx = BuildTransaction.ethereumEIP1559(
        wallet: wallet,
        amount: amount,
        toAddress: toAddress,
        nonce: 0,
        maxInclusionFeePerGas: '30000000000',
        maxFeePerGas: gasPrice,
        gasLimit: gasLimit,
        chainId: 137,
        coinType: TWCoinType.TWCoinTypePolygon,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 115);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f8708189808506fc23ac008509502f9000825208943e26e7f73a80444e67b7be654a38ab85ccb6ea47830e1af080c080a046e61269b37e4533cc7b4f0eced4970aa2f6986f1dc2e37dd11d773385b20eeaa022ae3ac2da537d252c29a3ca4437c2683bfeeaeb1a3c7760a98d79874d33455b',
        'networkFee': '840000000000000'
      });
    });
    test('Polygon ERC20 token transaction', () {
      final gasPrice = BigInt.from(40000000000);
      final signedEthTx = BuildTransaction.ethereumERC20TokenEIP1559(
        wallet: wallet,
        amount: amount,
        tokenContract: tokenContract,
        toAddress: toAddress,
        nonce: 0,
        maxInclusionFeePerGas: '30000000000',
        maxFeePerGas: gasPrice,
        gasLimit: gasLimit,
        chainId: 137,
        coinType: TWCoinType.TWCoinTypePolygon,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 181);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f8b28189808506fc23ac008509502f90008252089426fc591fecc4948c4288d95b6aadab00eba4e72a80b844a9059cbb0000000000000000000000003e26e7f73a80444e67b7be654a38ab85ccb6ea4700000000000000000000000000000000000000000000000000000000000e1af0c001a0472ab70dffd909bbbbafa44d3a4667007e1d31f05c7fa9db3e01420a910a3e66a01aee0ed1f99a0196fc3cad6076a41b0cc8bea07eac7ac937d75af2f0049fd17f',
        'networkFee': '840000000000000'
      });
    });
    test('Avalanche native transaction', () {
      final gasPrice = BigInt.from(27500000000);
      final signedEthTx = BuildTransaction.ethereumEIP1559(
        wallet: wallet,
        amount: amount,
        toAddress: toAddress,
        nonce: 0,
        maxInclusionFeePerGas: '2500000000',
        gasLimit: gasLimit,
        maxFeePerGas: gasPrice,
        chainId: 43114,
        coinType: TWCoinType.TWCoinTypeAvalancheCChain,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 115);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f87082a86a80849502f90085066720b300825208943e26e7f73a80444e67b7be654a38ab85ccb6ea47830e1af080c001a092703db2a272c447aed7a6f9dcb45a9be7a8adbd02fb2243e1b262b9a7196f5ca06593954e4681b11c1b66efb7f57a5d0e75ce7051406159df32ae911d2786e65d',
        'networkFee': '577500000000000'
      });
    });
    test('Avalanche ERC20 token transaction', () {
      final gasPrice = BigInt.from(27500000000);
      final signedEthTx = BuildTransaction.ethereumERC20TokenEIP1559(
        wallet: wallet,
        amount: amount,
        tokenContract: tokenContract,
        toAddress: toAddress,
        nonce: 0,
        maxInclusionFeePerGas: '2500000000',
        maxFeePerGas: gasPrice,
        gasLimit: gasLimit,
        chainId: 43114,
        coinType: TWCoinType.TWCoinTypeAvalancheCChain,
      );
      expect(hex.decode(signedEthTx.rawTx).length, 181);
      expect(signedEthTx.toJson(), {
        'txid':
            '02f8b282a86a80849502f90085066720b3008252089426fc591fecc4948c4288d95b6aadab00eba4e72a80b844a9059cbb0000000000000000000000003e26e7f73a80444e67b7be654a38ab85ccb6ea4700000000000000000000000000000000000000000000000000000000000e1af0c001a0f21de0b51c54e36cb6c29159dc1b4739bfa9021f44da94ecb70b38dee96b5f6ba02cca47c558692f087fb3469b78c5c9dcbdc97746e37062c8686d95739002a859',
        'networkFee': '577500000000000'
      });
    });
  });
}
