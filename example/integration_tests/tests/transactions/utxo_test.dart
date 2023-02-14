import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;

void main() {
  trust_core.HDWallet wallet;

  const mnemonic =
      'horror select baby exile convince sunset outside vehicle write decade powder energy';

  if (Mnemonic.isValid(mnemonic: mnemonic)) {
    wallet = Mnemonic.import(mnemonic: mnemonic);
  } else {
    throw Exception(['Mnemonic is not valid!']);
  }

  group('utxoCoinWithExceptionHandling transaction tests - ', () {
    final fee = BigInt.from(10);
    test('No utxo available - blockbook', () {
      const coin = TWCoinType.TWCoinTypeDogecoin;
      const toAddress = 'DK3AhJvD57AfUqFCp5MUV62GE6K4enGxSw';
      final amount = BigInt.from(1005000);
      // https://doge1.simplio.io/api/v2/utxo/DTbELQaWmv5KpFcNpZ9X9wy5RjQGL4YMm2
      const utxoString = '[]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoinWithExceptionHandling(
          wallet: wallet,
          coin: coin,
          toAddress: toAddress,
          amount: amount,
          byteFee: fee,
          utxo: utxo,
        );
      } catch (exception) {
        expect(exception, isA<NoUtxoAvailableException>());
      }
    });
    test('Amount > amount - estimated fee - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(38900);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoinWithExceptionHandling(
          wallet: wallet,
          coin: coin,
          toAddress: toAddress,
          amount: amount,
          byteFee: fee,
          utxo: utxo,
        );
      } catch (exception) {
        expect(exception, isA<LowTotalAmountPlusFeeException>());
      }
    });
    test('Amount > amount - estimated fee - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(38900);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoinWithExceptionHandling(
          wallet: wallet,
          coin: coin,
          toAddress: toAddress,
          amount: amount,
          byteFee: fee,
          utxo: utxo,
        );
      } catch (exception) {
        expect(exception, isA<LowTotalAmountPlusFeeException>());
      }
    });
    test('Valid utxoCoin transaction - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(25000);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 223);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f800000000000000000002a861000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd7c70a000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba902483045022100ad22e6db78e625ab2f1ee12e73222d1ddcab8cc6f3e4f806217bcf18dd74aca102201f013317e42e5a9c87e9a590045bdd209c60b41b052c08b3ecf3f33515df8244012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1410'
      });
    });
    test('Valid utxoCoin transaction - insight', () {
      const coin = TWCoinType.TWCoinTypeZelcash;
      const toAddress = 't1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w';
      final amount = BigInt.from(4000);
      // https://explorer.runonflux.io/api/addr/t1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w/utxo
      const utxoString =
          '[{"address":"t1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w","txid":"d44de5df6f6e6581dd5a8a16f3b2f1dcd4e2637699d38864d29a9e1b050496ef","vout":0,"scriptPubKey":"76a914c69c2c2a50ddd8fc960a0ef0cc3cdac9a3d995bc88ac","amount":0.000114,"satoshis":11400,"height":1142791,"confirmations":69}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 245);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '0400008085202f8901ef9604051b9e9ad26488d3997663e2d4dcf1b2f3168a5add81656e6fdfe54dd4000000006b4830450221008cf8ebe7b4cb60890bf04a1f004d4b75c9740d64b760a7dc6167a10d321e71b2022013f750b6746ba9287b2cea199afb69b977b4b89805d076ce0d340ab5edbbe22f012103c177cbfeb3f360aeb36e65c2ef70e4dcbd7a033faabd8f9a4ab100cb73b341fc0000000002a00f0000000000001976a914c69c2c2a50ddd8fc960a0ef0cc3cdac9a3d995bc88ac14140000000000001976a914b94b42a358f3dc8ec231d90eac15a59481d9440988ac00000000000000000000000000000000000000',
        'networkFee': '2260'
      });
    });
    test('Valid utxoCoin signed max amount - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(39169);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 339);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000102671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000010d92000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd702473044022035081f1a1f0572749e486cb6dd6548ac2ef0a4a55fac490e1f2e8eea78c69df6022033329399b4487e8b74c9ecbaa3fafd052facedc2c822e3423acd4de5bfbc991c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220784ec5be3350e7bb414154afb028fb7e6bc4eaf56b9f99d8aea918cd223872f10220259e550dec11b4d13562999079a8c7abb6cccfce265b840c633769f47d183a73012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1780'
      });
    });
    test('Valid utxoCoin signed max amount - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(39169);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 339);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000102671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000010d92000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd702473044022035081f1a1f0572749e486cb6dd6548ac2ef0a4a55fac490e1f2e8eea78c69df6022033329399b4487e8b74c9ecbaa3fafd052facedc2c822e3423acd4de5bfbc991c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220784ec5be3350e7bb414154afb028fb7e6bc4eaf56b9f99d8aea918cd223872f10220259e550dec11b4d13562999079a8c7abb6cccfce265b840c633769f47d183a73012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1780'
      });
    });
    test('Valid utxoCoin transaction one additional utxo add - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(9999);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 222);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000020f27000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd76045000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba9024730440220044a1392212fb469afb6dfa71c9644eeaa8568d73cc50d08318e1994d5b929a402205251975b001f3be28d1186b3307d5d5361c25e4d9e94d50ec3342f5cce9692b4012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1410'
      });
    });
    test('Valid utxoCoin transaction one additional utxo add - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(9999);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoinWithExceptionHandling(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 222);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000020f27000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd76045000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba9024730440220044a1392212fb469afb6dfa71c9644eeaa8568d73cc50d08318e1994d5b929a402205251975b001f3be28d1186b3307d5d5361c25e4d9e94d50ec3342f5cce9692b4012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1410'
      });
    });
  });

  group('utxoCoin transaction tests - ', () {
    final fee = BigInt.from(10);
    test('No utxo available - blockbook', () {
      const coin = TWCoinType.TWCoinTypeDogecoin;
      const toAddress = 'DK3AhJvD57AfUqFCp5MUV62GE6K4enGxSw';
      final amount = BigInt.from(1005000);
      // https://doge1.simplio.io/api/v2/utxo/DTbELQaWmv5KpFcNpZ9X9wy5RjQGL4YMm2
      const utxoString = '[]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 0);
      expect(signedUtxoCoinTx.toJson(), {'txid': '', 'networkFee': '0'});
    });
    test('Amount > balance - estimated fee (1 UTXO) - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(8261);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"10000","height":2252921,"confirmations":683}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {'txid': '', 'networkFee': '0'});
    });
    test('Amount = balance - estimated fee (1 UTXO) - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(8260);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":10000,"height":2252921,"confirmations":683}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000024420000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd74a01000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba90247304402206746d3e463ed9e2dad18598684ca79a1ab011327d0cc3235f2ef052fb4a2d9d902206cb73c213c29383e6bcbaca6a6022346440f70d30de06030a0107970a3d9d0a1012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '1740'
      });
    });
    test('Amount > balance - estimated fee (2 UTXOs) - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(37251);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"30000","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 0);
      expect(signedUtxoCoinTx.toJson(), {'txid': '', 'networkFee': '0'});
    });
    test('Amount = balance - estimated fee (2 UTXOs) - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(37250);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":30000,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 370);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000102671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000028291000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd79402000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba902473044022033c44b899e6dcf902a7af10f33d7572621e040246f372e5f240272c3acd4367002202dd381a107bb45a53d283ed79be804833b46d9664d3200f76bad8edc40f1b0dc012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d4960247304402207f2413c2412fe62cf523a20c1ccc6b026dd83747408d5109bcbe51cfcac72bf802203a1dcd37b0222d7ec99f894beede28c5c98b1ce0f6ca782e806126c33e988a65012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2750'
      });
    });
    test('Amount > balance - estimated fee (4 UTXOs) - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(95231);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"40000","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"30000","height":2252920,"confirmations":684},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"20000","height":2252920,"confirmations":684},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {'txid': '', 'networkFee': '0'});
    });
    test('Amount = balance - estimated fee (4 UTXOs) - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(95230);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":40000,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":30000,"height":2252920,"confirmations":684},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":20000,"height":2252920,"confirmations":684},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000104671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f800000000000000000002fe73010000000000160014bb8ef6a40ab316da000090c989372ac48f233fd72805000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba902483045022100a8b9e6233d0147e6e9f566a63de9e525abce074c7cd29ee2efca6b017e470a0f022039b379c8d22d973abe59ddeb3764ef35ee3e675fd251498a9b8c1c24a529798d012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602473044022047fe80822153d6b9705a947e2ef84efeda90970c24521a8ea41453cd13d237370220297fe894ee6bb4126411c2019623bed98ff159995e9f68b1499aa396696f2261012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602483045022100d4fe48b2bb6c2fd70e713e96c282467aea1bb23e7c466837615b052cf40147180220480388ca5d1115009fcaf7d6c5bfee2d80a0da8a38f686c180a86548a7e53393012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602483045022100b50ec8458c00e77b1d54b534dd8c92259bb3eba374a9fb4ec4ef5c2f7b95f7ae02201fac29051fcbda0e4bfc79b33c7aedc1fd20d3c7ed8d84736f6b6a61481e1ef1012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '4770'
      });
    });
    test('Amount > balance - estimated fee (11 UTXOs) - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(248141);
      const utxoString = '''[
            {"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"40000","height":2252923,"confirmations":681},
            {"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"40000","height":2252923,"confirmations":681},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"30000","height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"30000","height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"30000","height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"20000","height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"20000","height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"20000","height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}
            ]''';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {'txid': '', 'networkFee': '0'});
    });
    test('Amount = balance - estimated fee (11 UTXOs) - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(248140);
      const utxoString = '''[
            {"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":40000,"height":2252923,"confirmations":681},
            {"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":40000,"height":2252923,"confirmations":681},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":30000,"height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":30000,"height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":30000,"height":2252922,"confirmations":682},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":20000,"height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":20000,"height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":20000,"height":2252921,"confirmations":683},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684},
            {"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}
            ]''';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '0100000000010b671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000024cc9030000000000160014bb8ef6a40ab316da000090c989372ac48f233fd7420e000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba902473044022070a5fc25d52c04d39c014bd258e0532a320ab85c1ce35387ea7ae96b838c743b02206634bc3b5f6e8a159aa88f56f064124b55d34e564e29e87a95e938a008241a12012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602473044022070a5fc25d52c04d39c014bd258e0532a320ab85c1ce35387ea7ae96b838c743b02206634bc3b5f6e8a159aa88f56f064124b55d34e564e29e87a95e938a008241a12012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602473044022070a5fc25d52c04d39c014bd258e0532a320ab85c1ce35387ea7ae96b838c743b02206634bc3b5f6e8a159aa88f56f064124b55d34e564e29e87a95e938a008241a12012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d4960247304402207d0a45eeef75be42330becbb76519df112e3d63cf2c825cd8a9983ce71b69bff02200f152f5dbc98fe70df0f63964a612a679a07edbc76cdfee05d0177b32c3b4b6c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d4960247304402207d0a45eeef75be42330becbb76519df112e3d63cf2c825cd8a9983ce71b69bff02200f152f5dbc98fe70df0f63964a612a679a07edbc76cdfee05d0177b32c3b4b6c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d4960247304402207d0a45eeef75be42330becbb76519df112e3d63cf2c825cd8a9983ce71b69bff02200f152f5dbc98fe70df0f63964a612a679a07edbc76cdfee05d0177b32c3b4b6c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220536186a3214ce93bfc76850105072b584b43c8ddb9bf4f88d9b7b8519ed630c2022055fd3de4c8a461783f636ecff04c4746af34882e65d0567ce4288c6ca28a8594012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220536186a3214ce93bfc76850105072b584b43c8ddb9bf4f88d9b7b8519ed630c2022055fd3de4c8a461783f636ecff04c4746af34882e65d0567ce4288c6ca28a8594012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220536186a3214ce93bfc76850105072b584b43c8ddb9bf4f88d9b7b8519ed630c2022055fd3de4c8a461783f636ecff04c4746af34882e65d0567ce4288c6ca28a8594012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602483045022100b912341ae365eeecd991e70a022c88b90c9897efd5c3ddb38f9248f55734f0db0220639d54091c1ff6a486c2582d30cc322f5642a7790f3c8f4eeea17f8c8c4aaa11012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49602483045022100b912341ae365eeecd991e70a022c88b90c9897efd5c3ddb38f9248f55734f0db0220639d54091c1ff6a486c2582d30cc322f5642a7790f3c8f4eeea17f8c8c4aaa11012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '11860'
      });
    });
    test('Valid utxoCoin transaction - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(25000);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 223);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f800000000000000000002a861000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd7c70a000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba902483045022100ad22e6db78e625ab2f1ee12e73222d1ddcab8cc6f3e4f806217bcf18dd74aca102201f013317e42e5a9c87e9a590045bdd209c60b41b052c08b3ecf3f33515df8244012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2750'
      });
    });
    test('Valid utxoCoin transaction - insight', () {
      const coin = TWCoinType.TWCoinTypeZelcash;
      const toAddress = 't1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w';
      final amount = BigInt.from(4000);
      // https://explorer.runonflux.io/api/addr/t1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w/utxo
      const utxoString =
          '[{"address":"t1byktNheu1vBB5YkwKY1zvQDcAt5c44v8w","txid":"d44de5df6f6e6581dd5a8a16f3b2f1dcd4e2637699d38864d29a9e1b050496ef","vout":0,"scriptPubKey":"76a914c69c2c2a50ddd8fc960a0ef0cc3cdac9a3d995bc88ac","amount":0.000114,"satoshis":11400,"height":1142791,"confirmations":69}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 245);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '0400008085202f8901ef9604051b9e9ad26488d3997663e2d4dcf1b2f3168a5add81656e6fdfe54dd4000000006b4830450221008cf8ebe7b4cb60890bf04a1f004d4b75c9740d64b760a7dc6167a10d321e71b2022013f750b6746ba9287b2cea199afb69b977b4b89805d076ce0d340ab5edbbe22f012103c177cbfeb3f360aeb36e65c2ef70e4dcbd7a033faabd8f9a4ab100cb73b341fc0000000002a00f0000000000001976a914c69c2c2a50ddd8fc960a0ef0cc3cdac9a3d995bc88ac14140000000000001976a914b94b42a358f3dc8ec231d90eac15a59481d9440988ac00000000000000000000000000000000000000',
        'networkFee': '2260'
      });
    });
    test('Valid utxoCoin signed max amount - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(39169);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 339);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000102671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000010d92000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd702473044022035081f1a1f0572749e486cb6dd6548ac2ef0a4a55fac490e1f2e8eea78c69df6022033329399b4487e8b74c9ecbaa3fafd052facedc2c822e3423acd4de5bfbc991c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220784ec5be3350e7bb414154afb028fb7e6bc4eaf56b9f99d8aea918cd223872f10220259e550dec11b4d13562999079a8c7abb6cccfce265b840c633769f47d183a73012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2440'
      });
    });
    test('Valid utxoCoin signed max amount - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(39169);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 339);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000102671c5acba4e09945409134f92c7811404ad14808ebc93e9c5a780d4ae5a85d6e000000000000000000f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000010d92000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd702473044022035081f1a1f0572749e486cb6dd6548ac2ef0a4a55fac490e1f2e8eea78c69df6022033329399b4487e8b74c9ecbaa3fafd052facedc2c822e3423acd4de5bfbc991c012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d496024730440220784ec5be3350e7bb414154afb028fb7e6bc4eaf56b9f99d8aea918cd223872f10220259e550dec11b4d13562999079a8c7abb6cccfce265b840c633769f47d183a73012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2440'
      });
    });
    test('Valid utxoCoin transaction one additional utxo add - blockbook', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(9999);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 222);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000020f27000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd76045000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba9024730440220044a1392212fb469afb6dfa71c9644eeaa8568d73cc50d08318e1994d5b929a402205251975b001f3be28d1186b3307d5d5361c25e4d9e94d50ec3342f5cce9692b4012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2750'
      });
    });
    test('Valid utxoCoin transaction one additional utxo add - insight', () {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(9999);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      final signedUtxoCoinTx = BuildTransaction.utxoCoin(
        wallet: wallet,
        coin: coin,
        toAddress: toAddress,
        amount: amount,
        byteFee: fee,
        utxo: utxo,
      );
      expect(hex.decode(signedUtxoCoinTx.rawTx).length, 222);
      expect(signedUtxoCoinTx.toJson(), {
        'txid':
            '01000000000101f59ead966057be1c871f50f98cf21428c078eff962ae7efcf79ed8de55f473f8000000000000000000020f27000000000000160014bb8ef6a40ab316da000090c989372ac48f233fd76045000000000000160014ac9a7a96a4e4fd16539f53b1fa062afe0dbd6ba9024730440220044a1392212fb469afb6dfa71c9644eeaa8568d73cc50d08318e1994d5b929a402205251975b001f3be28d1186b3307d5d5361c25e4d9e94d50ec3342f5cce9692b4012102a91d09121aff91972942758b4e827f18c27305af2085459555f989fbf105d49600000000',
        'networkFee': '2750'
      });
    });
  });
}
