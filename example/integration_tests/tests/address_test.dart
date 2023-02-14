import 'package:test/test.dart';
import './address/atom_test.dart' as atom;
import 'address/avax_test.dart' as avax;
import 'address/bch_test.dart' as bch;
import 'address/bnb_test.dart' as bnb;
import 'address/btc_test.dart' as btc;
import 'address/dash_test.dart' as dash;
import 'address/dgb_test.dart' as dgb;
import 'address/doge_test.dart' as doge;
import 'address/etc_test.dart' as etc;
import 'address/eth_test.dart' as eth;
import 'address/flux_test.dart' as flux;
import 'address/ltc_test.dart' as ltc;
import 'address/matic_test.dart' as matic;
import 'address/osmo_test.dart' as osmo;
import 'address/sol_test.dart' as sol;
import 'address/zec_test.dart' as zec;

void main() {
  group('Public Address tests -', () {
    atom.main();
    avax.main();
    bch.main();
    bnb.main();
    btc.main();
    dash.main();
    dgb.main();
    doge.main();
    etc.main();
    eth.main();
    flux.main();
    ltc.main();
    matic.main();
    osmo.main();
    sol.main();
    zec.main();
  });
}
