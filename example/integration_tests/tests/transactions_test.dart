import 'package:test/test.dart';
import './transactions/cosmos_test.dart' as cosmos;
import './transactions/ethereum_test.dart' as ethereum;
import './transactions/solana_test.dart' as solana;
import './transactions/utxo_test.dart' as utxo;

void main() {
  group('Transaction tests - ', () {
    cosmos.main();
    ethereum.main();
    solana.main();
    utxo.main();
  });
}
