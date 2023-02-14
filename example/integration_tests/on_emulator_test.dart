import 'package:integration_test/integration_test.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;
import './tests/address_test.dart' as address;
import './tests/mnemonic_test.dart' as mnemonic;
import './tests/message_signing_test.dart' as message_sign;
import './tests/transactions/cosmos_test.dart' as transactions_cosmos;
import './tests/transactions/ethereum_test.dart' as transactions_ethereum;
import './tests/transactions/solana_test.dart' as transactions_solana;
import './tests/transactions/utxo_test.dart' as transactions_utxo;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  trust_core.TrustWalletCoreLib.init();

  address.main();
  mnemonic.main();
  message_sign.main();
  transactions_cosmos.main();
  transactions_ethereum.main();
  transactions_solana.main();
  transactions_utxo.main();
}
