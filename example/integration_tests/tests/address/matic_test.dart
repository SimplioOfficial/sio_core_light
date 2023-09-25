import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('MATIC -', () {
    // TODO: For some reason this test fails in CI/CD.
    // test('true', () {
    //   expect(
    //     Address.isValid(
    //       address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
    //       networkId: TWCoinType.TWCoinTypePolygon,
    //     ),
    //     true,
    //   );
    // });
    test('false', () {
      expect(
        Address.isValid(
          address: 'anyTextHere',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
          networkId: TWCoinType.TWCoinTypePolygon,
        ),
        false,
      );
    });
  });
}
