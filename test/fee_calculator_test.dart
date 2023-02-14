import 'package:sio_core_light/sio_core_light.dart';
import 'package:test/test.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('Fee calculator - ', () {
    test('_decredFeeCalculator', () {
      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeDecred),
          BigInt.from(216));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeDecred),
          BigInt.from(382));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeDecred),
          BigInt.from(254));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeDecred),
          BigInt.from(2540));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeDecred),
          BigInt.from(5156));
    });
    test('_defaultFeeCalculator', () {
      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinCash),
          BigInt.from(192));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinCash),
          BigInt.from(340));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeBitcoinCash),
          BigInt.from(226));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinCash),
          BigInt.from(2264));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeBitcoinCash),
          BigInt.from(4596));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeZcash),
          BigInt.from(192));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeZcash),
          BigInt.from(340));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeZcash),
          BigInt.from(226));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeZcash),
          BigInt.from(2264));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeZcash),
          BigInt.from(4596));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeZelcash),
          BigInt.from(192));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeZelcash),
          BigInt.from(340));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeZelcash),
          BigInt.from(226));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeZelcash),
          BigInt.from(2264));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeZelcash),
          BigInt.from(4596));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeDash),
          BigInt.from(192));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeDash),
          BigInt.from(340));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeDash),
          BigInt.from(226));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeDash),
          BigInt.from(2264));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeDash),
          BigInt.from(4596));
    });
    test('_segwitFeeCalculator', () {
      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoin),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoin),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeBitcoin),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoin),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeBitcoin),
          BigInt.from(3182));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinGold),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinGold),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeBitcoinGold),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeBitcoinGold),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeBitcoinGold),
          BigInt.from(3182));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeDigiByte),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeDigiByte),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeDigiByte),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeDigiByte),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeDigiByte),
          BigInt.from(3182));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeLitecoin),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeLitecoin),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeLitecoin),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeLitecoin),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeLitecoin),
          BigInt.from(3182));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeViacoin),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeViacoin),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeViacoin),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeViacoin),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeViacoin),
          BigInt.from(3182));

      expect(feeCalculator(1, 1, BigInt.one, TWCoinType.TWCoinTypeGroestlcoin),
          BigInt.from(143));
      expect(feeCalculator(2, 1, BigInt.one, TWCoinType.TWCoinTypeGroestlcoin),
          BigInt.from(244));
      expect(feeCalculator(1, 2, BigInt.one, TWCoinType.TWCoinTypeGroestlcoin),
          BigInt.from(174));
      expect(feeCalculator(15, 1, BigInt.one, TWCoinType.TWCoinTypeGroestlcoin),
          BigInt.from(1560));
      expect(feeCalculator(15, 2, BigInt.two, TWCoinType.TWCoinTypeGroestlcoin),
          BigInt.from(3182));
    });
  });
}
