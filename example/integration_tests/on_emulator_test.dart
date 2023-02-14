import 'package:integration_test/integration_test.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;
import './tests/address_test.dart' as address;
import './tests/mnemonic_test.dart' as mnemonic;
import './tests/message_signing_test.dart' as message_sign;
import './tests/transactions_test.dart' as transactions;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  trust_core.TrustWalletCoreLib.init();

  address.main();
  mnemonic.main();
  message_sign.main();
  transactions.main();
}
