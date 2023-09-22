import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('FLUX -', () {
    test('true', () {
      expect(
        Address.isValid(
          address: 't1feoeVnz3BKkE5b5AVS5ySZLmbRRnCV6CH',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        true,
      );
      expect(
        Address.isValid(
          address: 't3ZWyRPpWRo23pKxTLtWsnfEKeq9T4XPxKM',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        true,
      );
    });
    test('false', () {
      expect(
        Address.isValid(
          address: 'anyTextHere',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
          networkId: TWCoinType.TWCoinTypeZelcash,
        ),
        false,
      );
    });
  });
}
