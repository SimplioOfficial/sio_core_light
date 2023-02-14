import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('BCH -', () {
    test('true', () {
      expect(
        Address.isValid(
          address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        true,
      );
      expect(
        Address.isValid(
          address: '15c4EbHAe7hU5ZhzpmTn5vXihcM5DdzDGw',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        true,
      );
    });
    test('false', () {
      expect(
        Address.isValid(
          address: 'anyTextHere',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address:
              'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
          networkId: TWCoinType.TWCoinTypeBitcoinCash,
        ),
        false,
      );
    });
  });
}
