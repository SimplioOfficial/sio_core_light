import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('LTC -', () {
    test('true', () {
      expect(
        Address.isValid(
          address: 'ltc1q3ghzmftdu02rljqucej2sxjmx7tf6a6y0wtywa',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        true,
      );
      expect(
        Address.isValid(
          address: 'LcNS6c8RddAMjewDrUAAi8BzecKoosnkN3',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        true,
      );
      expect(
        Address.isValid(
          address: 'MHQ9ZDRvGTfe8YhkwUGpcqb39NR7JbFMeM',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        true,
      );
    });
    test('false', () {
      expect(
        Address.isValid(
          address: 'anyTextHere',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address:
              'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
      expect(
        Address.isValid(
          address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
          networkId: TWCoinType.TWCoinTypeLitecoin,
        ),
        false,
      );
    });
  });
}
