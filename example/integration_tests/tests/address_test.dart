import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

void main() {
  group('Public Address tests -', () {
    group('ATOM -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeCosmos,
          ),
          false,
        );
      });
    });

    group('AVAX -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeAvalancheCChain,
          ),
          false,
        );
      });
    });

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

    group('BNB -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeSmartChain,
          ),
          false,
        );
      });
    });

    group('BTC -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          true,
        );
        expect(
          Address.isValid(
            address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          true,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          true,
        );
        expect(
          Address.isValid(
            address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeBitcoin,
          ),
          false,
        );
      });
    });

    group('DASH -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeDash,
          ),
          false,
        );
      });
    });

    group('DGB -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          true,
        );
        expect(
          Address.isValid(
            address: 'DFHvtSCQRjfeEHX7JFhJ3JML8BihQ5DNMz',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeDigiByte,
          ),
          false,
        );
      });
    });

    group('DOGE -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'DKc6JWqxixtQJpYx8fvyFYv6zk9tzS6fSn',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeDogecoin,
          ),
          false,
        );
      });
    });

    group('ETC -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeEthereumClassic,
          ),
          false,
        );
      });
    });

    group('ETH -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeEthereum,
          ),
          false,
        );
      });
    });

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
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
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

    group('OSMO -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeOsmosis,
          ),
          false,
        );
      });
    });

    group('MATIC -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypePolygon,
          ),
          true,
        );
      });
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
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
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

    group('SOL -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 'FTVQsM8FTP8pdp2vdMdi2LQETZPpEKhrsa4MAdtxYDxw',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address:
                'bc1qwqdg6squsna38e46795at95yu9atm8azzmyvckulcc7kytlcckxswvvzej',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'dgb1qfhaxur8hulu0sqnqm899tts04lzvpz9ylq34ph',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'cosmos1s0ml67mu8y9y4gzfvc9q6ax96umt9gu0xc27sw',
            networkId: TWCoinType.TWCoinTypeSolana,
          ),
          false,
        );
      });
    });

    group('ZEC -', () {
      test('true', () {
        expect(
          Address.isValid(
            address: 't1feoeVnz3BKkE5b5AVS5ySZLmbRRnCV6CH',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          true,
        );
        expect(
          Address.isValid(
            address: 't3ZWyRPpWRo23pKxTLtWsnfEKeq9T4XPxKM',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          true,
        );
      });
      test('false', () {
        expect(
          Address.isValid(
            address: 'anyTextHere',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '0x3E26e7F73A80444e67b7bE654A38aB85ccb6ea47',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bc1qh89qqemkdfzmcvlaavnzgyn9zuzp0rq08y6nte',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: '38WeDaCttgmCzkeFE8TgAtzfZRuFumb2df',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'bitcoincash:qqegrshat6uxp4tuy4ca68ddljzhztqxsssyvmss39',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'XpL19hC7VaC4XBi1aBrgvP7wdatDzYoXgP',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
        expect(
          Address.isValid(
            address: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
            networkId: TWCoinType.TWCoinTypeZcash,
          ),
          false,
        );
      });
    });
  });
}
