import 'dart:convert';

import 'package:bs58/bs58.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;

void main() {
  trust_core.TrustWalletCoreLib.init();
  trust_core.HDWallet wallet;

  const mnemonic =
      'horror select baby exile convince sunset outside vehicle write decade powder energy';

  if (Mnemonic.isValid(mnemonic: mnemonic)) {
    wallet = Mnemonic.import(mnemonic: mnemonic);
  } else {
    throw Exception(['Mnemonic is not valid!']);
  }

  group('Mnemonic tests - ', () {
    const mnemonic12Words =
        'rent craft script crucial item someone dream federal notice page shrug pipe young hover duty';
    const mnemonic24Words =
        'trouble sand fringe fox spatial film attract domain biology exchange twist audit nose raccoon steel warrior arrest nut card skirt uniform super make gloom';
    test('Mnemonic of 12 words is valid', () {
      expect(Mnemonic.isValid(mnemonic: mnemonic12Words), equals(true));
    });
    test('Mnemonic of 24 words is valid', () {
      expect(Mnemonic.isValid(mnemonic: mnemonic24Words), equals(true));
    });
    test('Generated mnemonic has 12 words', () {
      expect(Mnemonic().generate.split(' ').length, equals(12));
    });
    test('Import 12 seed mnemonic', () {
      expect(Mnemonic.import(mnemonic: mnemonic12Words).mnemonic(),
          equals(mnemonic12Words));
    });
    test('Import 24 seed mnemonic', () {
      expect(Mnemonic.import(mnemonic: mnemonic24Words).mnemonic(),
          equals(mnemonic24Words));
    });
  });

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

  group('Cosmos transaction tests - ', () {
    test('Osmosis', () {
      final signedOsmoTx = BuildTransaction.cosmos(
        wallet: wallet,
        coin: TWCoinType.TWCoinTypeOsmosis,
        amount: '10000',
        toAddress: 'osmo1qrhlvrqctv26vn6az7rnunredgy249sm9jt7us',
        chainId: 'osmosis-1',
        denomination: 'uosmo',
        accountNumber: '456069',
        sequence: '0',
        fee: '100',
        gas: '200000',
      );

      expect(signedOsmoTx.toJson(), {
        'txid':
            '{"mode":"BROADCAST_MODE_BLOCK","tx_bytes":"Co0BCooBChwvY29zbW9zLmJhbmsudjFiZXRhMS5Nc2dTZW5kEmoKK29zbW8xcmx3ZW10NDVyeXpjOHluYWt6d2dma2x0bTdqeThsc3dwbmZzd24SK29zbW8xcXJobHZycWN0djI2dm42YXo3cm51bnJlZGd5MjQ5c205anQ3dXMaDgoFdW9zbW8SBTEwMDAwEmQKTgpGCh8vY29zbW9zLmNyeXB0by5zZWNwMjU2azEuUHViS2V5EiMKIQNPQtmB3SddtiaNalrHzaNlRZlTjV31pqIQZv4WvuRtKRIECgIIARISCgwKBXVvc21vEgMxMDAQwJoMGkDnEDf6YUI4aZ0zIGxnL1GFs/qdSg7q2ymGFm7M/M/BKFQlf8QUd6WZQ+J2D05t3N6xgclxVqPMCCdYm9bevc1e"}',
        'networkFee': '100'
      });
    });
  });

  group('Ethereum transaction tests - ', () {
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

  group('Solana transactions tests - ', () {
    const toAddress = '3fTR8GGL2mniGyHtd3Qy2KDVhZ9LHbW59rCc7A3RtBWk';
    const tokenMintAddress = 'SioTkQxHyAs98ouRiyi1YDv3gLMSrX3eNBg61GH7NrM';
    final amount = BigInt.from(4000);
    final fee = BigInt.from(5000);
    const decimals = 8;
    test('Native transaction', () async {
      final signedSolanaTx = BuildTransaction.solana(
        wallet: wallet,
        recipient: toAddress,
        amount: amount,
        fee: fee,
        latestBlockHash: '11111111111111111111111111111111',
      );
      expect(base58.decode(signedSolanaTx.rawTx).length, 215);
      expect(signedSolanaTx.toJson(), {
        'txid':
            '3zWUJPKRuoYY39TFcezbAxEgnYQ6vdhxHrKR9AfHBwe1jqVeAEREwoSWC1JyuyayggHvMjBjpBzR4EGyAFeR4cYTDB2ivdKmRM56P2vEgZkmEAt57LTxwtVM1isG88Fo9fqkT14vnrkke1tRbD8ivG6BEwhDvYURy1Z9RyKe3QozAKcP28mUyaCeBdjd4LgvmyDNCvstDmT2DADeD6qYoZZHxVNGxpjnR7rQfuG8UgfNWcixZFJkQB7k5SkDE5GuTxZqnHy4M87QdvCc7qKWrGGnmD9j8sQeycJk7',
        'networkFee': '5000'
      });
    });
    test('Token transaction', () async {
      final signedSolanaTokenTx = BuildTransaction.solanaToken(
        wallet: wallet,
        recipientSolanaAddress: toAddress,
        tokenMintAddress: tokenMintAddress,
        amount: amount,
        fee: fee,
        decimals: decimals,
        latestBlockHash: '11111111111111111111111111111111',
      );
      expect(base58.decode(signedSolanaTokenTx.rawTx).length, 279);
      expect(signedSolanaTokenTx.toJson(), {
        'txid':
            'LMcrASBJnPkjYi5VWC4kjDSDUQ3yPruwqD3EQRH1o1nEEZUYvAvzfF2ZB8E1yL78zJPPCCMQUe9BpJpGR4YJ8Y7ZZ7x7N9KtJEQb9MbtgFaL3GdXvA41suG3KCckRXKwXikZhxgjUCASruE79H1bWZ5rqCCwAhv54SUobj1GvnFXtPaQu9iQG4mGJjEyy44ctBFJatbwBfXwZSKJBVXaYwkpdN2fZy3wZNPt9pFK9BF72n5C3s99Vc9CzrzM9tfE2TKjKE6CopYATdeb1qmVDYVxnj3ZdaJGp7RHP61sGhY21iHQt47E7naMtCSTkjxohUfcirTahTYAcbmZD3iwAKcYRmuCk5PaeSCnL42MYhEE5WsG97sWL5Gk9Nrj',
        'networkFee': '5000'
      });
    });
  });

  group('UtxoCoin transaction tests - ', () {
    final fee = BigInt.from(10);
    test('No utxo available - blockbook', () async {
      const coin = TWCoinType.TWCoinTypeDogecoin;
      const toAddress = 'DK3AhJvD57AfUqFCp5MUV62GE6K4enGxSw';
      final amount = BigInt.from(1005000);
      // https://doge1.simplio.io/api/v2/utxo/DTbELQaWmv5KpFcNpZ9X9wy5RjQGL4YMm2
      const utxoString = '[]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoin(
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
    test('Total amount < amount + estimated fee (1000 sats) - blockbook',
        () async {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(38900);
      // https://ltc1.simplio.io/api/v2/utxo/ltc1qulzv02h8nmsuqxaqas3dv22cl244r7vs0smssh
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"value":"29169","height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"value":"10000","height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoin(
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
    test('Total amount < amount + estimated fee (1000 sats) - insight',
        () async {
      const coin = TWCoinType.TWCoinTypeLitecoin;
      const toAddress = 'ltc1qhw80dfq2kvtd5qqqjrycjde2cj8jx07h98rj0z';
      final amount = BigInt.from(38900);
      const utxoString =
          '[{"txid":"f873f455ded89ef7fc7eae62f9ef78c02814f28cf9501f871cbe576096ad9ef5","vout":0,"satoshis":29169,"height":2252921,"confirmations":683},{"txid":"6e5da8e54a0d785a9c3ec9eb0848d14a4011782cf93491404599e0a4cb5a1c67","vout":0,"satoshis":10000,"height":2252920,"confirmations":684}]';
      List utxo = jsonDecode(utxoString);
      try {
        BuildTransaction.utxoCoin(
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
    test('Valid utxoCoin transaction - blockbook', () async {
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
        'networkFee': '1410'
      });
    });

    test('Valid utxoCoin transaction - insight', () async {
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

    test('Valid utxoCoin signed max amount - blockbook', () async {
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
        'networkFee': '1780'
      });
    });

    test('Valid utxoCoin transaction one additional utxo add - blockbook',
        () async {
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
        'networkFee': '1410'
      });
    });

    test('Valid utxoCoin transaction one additional utxo add - insight',
        () async {
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
        'networkFee': '1410'
      });
    });
  });

  group('Ethereum Signing - ', () {
    test('Test typeData return correct signature', () {
      expect(
          EthSign.typedData(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            jsonData:
                '{"types":{"EIP712Domain":[{"name":"name","type":"string"},{"name":"version","type":"string"},{"name":"verifyingContract","type":"address"}],"RelayRequest":[{"name":"target","type":"address"},{"name":"encodedFunction","type":"bytes"},{"name":"gasData","type":"GasData"},{"name":"relayData","type":"RelayData"}],"GasData":[{"name":"gasLimit","type":"uint256"},{"name":"gasPrice","type":"uint256"},{"name":"pctRelayFee","type":"uint256"},{"name":"baseRelayFee","type":"uint256"}],"RelayData":[{"name":"senderAddress","type":"address"},{"name":"senderNonce","type":"uint256"},{"name":"relayWorker","type":"address"},{"name":"paymaster","type":"address"}]},"domain":{"name":"GSN Relayed Transaction","version":"1","chainId":42,"verifyingContract":"0x6453D37248Ab2C16eBd1A8f782a2CBC65860E60B"},"primaryType":"RelayRequest","message":{"target":"0x9cf40ef3d1622efe270fe6fe720585b4be4eeeff","encodedFunction":"0xa9059cbb0000000000000000000000002e0d94754b348d208d64d52d78bcd443afa9fa520000000000000000000000000000000000000000000000000000000000000007","gasData":{"gasLimit":"39507","gasPrice":"1700000000","pctRelayFee":"70","baseRelayFee":"0"},"relayData":{"senderAddress":"0x22d491bde2303f2f43325b2108d26f1eaba1e32b","senderNonce":"3","relayWorker":"0x3baee457ad824c94bd3953183d725847d023a2cf","paymaster":"0x957F270d45e9Ceca5c5af2b49f1b5dC1Abb0421c"}}}',
          ),
          equals(
              '0x6ee63a1fcfcd81c6d8c168a63e27eda62bf663495729fb3b2ad59ded9c1e41703a3f3597c4d1564c4ef0f56acef83b024af4a13099f4ebf1c608714736af4b5c1b'));
    });
    test('Test personalTypeData return correct signature', () {
      expect(
          EthSign.personalTypedData(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            jsonData:
                '{"types":{"EIP712Domain":[{"name":"name","type":"string"},{"name":"version","type":"string"},{"name":"verifyingContract","type":"address"}],"RelayRequest":[{"name":"target","type":"address"},{"name":"encodedFunction","type":"bytes"},{"name":"gasData","type":"GasData"},{"name":"relayData","type":"RelayData"}],"GasData":[{"name":"gasLimit","type":"uint256"},{"name":"gasPrice","type":"uint256"},{"name":"pctRelayFee","type":"uint256"},{"name":"baseRelayFee","type":"uint256"}],"RelayData":[{"name":"senderAddress","type":"address"},{"name":"senderNonce","type":"uint256"},{"name":"relayWorker","type":"address"},{"name":"paymaster","type":"address"}]},"domain":{"name":"GSN Relayed Transaction","version":"1","chainId":42,"verifyingContract":"0x6453D37248Ab2C16eBd1A8f782a2CBC65860E60B"},"primaryType":"RelayRequest","message":{"target":"0x9cf40ef3d1622efe270fe6fe720585b4be4eeeff","encodedFunction":"0xa9059cbb0000000000000000000000002e0d94754b348d208d64d52d78bcd443afa9fa520000000000000000000000000000000000000000000000000000000000000007","gasData":{"gasLimit":"39507","gasPrice":"1700000000","pctRelayFee":"70","baseRelayFee":"0"},"relayData":{"senderAddress":"0x22d491bde2303f2f43325b2108d26f1eaba1e32b","senderNonce":"3","relayWorker":"0x3baee457ad824c94bd3953183d725847d023a2cf","paymaster":"0x957F270d45e9Ceca5c5af2b49f1b5dC1Abb0421c"}}}',
          ),
          equals(
              '0xe742241a8d26e68ba86b854783bba9e8898996776788945a6ebbc6173a741ebb553ce9f41805b7815041dda4587c374591291a07473b9ae7050254ce2f7464ce1c'));
    });
    test('Test message return correct signature', () {
      expect(
          EthSign.message(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            message:
                '0xf737d8ba29fa34adf29b88785edca25c873d6fb2eaa4e77394cab27131fa3284',
          ),
          equals(
              '0xce929bf4483308f0e23752d43cb45def3bfafefdaba1b328d8121969ac303fd955acc4dd5520f585ee3691e04e0917f99360fa24a8280805ff25aa879fb83ae81c'));
      expect(
          EthSign.message(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            message: 'We are Simplio!',
          ),
          equals(
              '0xc925dc32a276bb6e4089bc161022f6a25819c29a31cf36fdcbcb489dba6f0e5105d77f17a021322f7cfa224a1f962929ff626396d886dd7d0af0bee946d1278d1b'));
    });
    test('Test personalMessage return correct signature', () {
      expect(
          EthSign.personalMessage(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            message:
                '0x4d7920656d61696c206973206a6f686e40646f652e636f6d202d205468752c2031352053657020323032322031333a30383a313520474d54',
          ),
          equals(
              '0x2913768a701ea3bea19b5d61d4b70758bf6b805869dea9425edc18e2efa2aa5c61add9bef273d29b4633972a1f35cc5efec23d7c8aeab358efedc2024d555bb01b'));
      expect(
          EthSign.personalMessage(
            wallet: wallet,
            networkId: TWCoinType.TWCoinTypeEthereum,
            message: 'We are Simplio!',
          ),
          equals(
              '0x6ac9dd87d1c807a5f69c7fb4b72992a25cf2eafcd2063ceda8b273950e43a95533219e419a0a9201691da1fc128716d282e83c6e9c1bcf3a453805ce628215701b'));
    });
  });
}
