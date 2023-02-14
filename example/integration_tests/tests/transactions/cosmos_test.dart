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
}
