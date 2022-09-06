import 'package:flutter/material.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sio_core_light example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'sio_core_light example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late trust_core.HDWallet wallet;

  final mnemonic =
      'horror select baby exile convince sunset outside vehicle write decade powder energy';

  Future<String> example() async {
    if (Mnemonic.isValid(mnemonic: mnemonic)) {
      wallet = Mnemonic.import(mnemonic: mnemonic);
      debugPrint('Mnemonic: $mnemonic');
    } else {
      throw Exception(['Mnemonic is not valid!']);
    }
    final solAddress = wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
    debugPrint('Solana address: $solAddress');

    const toAddress = '3fTR8GGL2mniGyHtd3Qy2KDVhZ9LHbW59rCc7A3RtBWk';
    const amount = '2000';
    // This must be fetched  from network with the correct api call
    const latestBlockHash = '11111111111111111111111111111111';

    final signedSolanaTx = BuildTransaction.solana(
      recipient: toAddress,
      amount: amount,
      wallet: wallet,
      latestBlockHash: latestBlockHash,
    );
    debugPrint('Raw Solana Transaction: ${signedSolanaTx.toJson()}');

    const tokenMintAddress = 'SioTkQxHyAs98ouRiyi1YDv3gLMSrX3eNBg61GH7NrM';
    final signedSolanaTokenTx = BuildTransaction.solanaToken(
      amount: amount,
      decimals: 8,
      tokenMintAddress: tokenMintAddress,
      recipientSolanaAddress: toAddress,
      wallet: wallet,
      latestBlockHash: latestBlockHash,
    );
    debugPrint('Raw Solana Token Transaction: ${signedSolanaTokenTx.toJson()}');

    return 'Success';
  }

  @override
  void initState() {
    trust_core.TrustWalletCoreLib.init();
    super.initState();
    example();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[],
      ),
    );
  }
}
