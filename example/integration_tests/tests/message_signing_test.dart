import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart' as trust_core;

void main() {
  trust_core.HDWallet wallet;

  const mnemonic = 'horror select baby exile convince sunset outside vehicle write decade powder energy';

  if (Mnemonic.isValid(mnemonic: mnemonic)) {
    wallet = Mnemonic.import(mnemonic: mnemonic);
  } else {
    throw Exception(['Mnemonic is not valid!']);
  }

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
            message: '0xf737d8ba29fa34adf29b88785edca25c873d6fb2eaa4e77394cab27131fa3284',
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
