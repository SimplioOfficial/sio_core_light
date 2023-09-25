import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

const double _defaultBytesPerInput = 148;
const double _defaultBytesPerOutput = 34;
const double _defaultBytesBase = 10;
const double _segwitBytesPerInput = 101.25;
const double _segwitBytesPerOutput = 31;
const double _segwitBytesBase = _defaultBytesBase;
const double _decredBytesPerInput = 166;
const double _decredBytesPerOutput = 38;
const double _decredBytesBase = 12;

BigInt _decredFeeCalculator(int inputs, int outputs, BigInt byteFee) {
  final txSize =
      BigInt.from((_decredBytesPerInput * inputs + _decredBytesPerOutput * outputs + _decredBytesBase).ceil());

  return txSize * byteFee;
}

BigInt _defaultFeeCalculator(int inputs, int outputs, BigInt byteFee) {
  final txSize =
      BigInt.from((_defaultBytesPerInput * inputs + _defaultBytesPerOutput * outputs + _defaultBytesBase).ceil());

  return txSize * byteFee;
}

BigInt _segwitFeeCalculator(int inputs, int outputs, BigInt byteFee) {
  final txSize =
      BigInt.from((_segwitBytesPerInput * inputs + _segwitBytesPerOutput * outputs + _segwitBytesBase).ceil());

  return txSize * byteFee;
}

BigInt feeCalculator(int inputs, int outputs, BigInt byteFee, int coinType) {
  switch (coinType) {
    case TWCoinType.TWCoinTypeDecred:
      return _decredFeeCalculator(inputs, outputs, byteFee);

    case TWCoinType.TWCoinTypeBitcoin:
    case TWCoinType.TWCoinTypeBitcoinGold:
    case TWCoinType.TWCoinTypeDigiByte:
    case TWCoinType.TWCoinTypeLitecoin:
    case TWCoinType.TWCoinTypeViacoin:
    case TWCoinType.TWCoinTypeGroestlcoin:
      return _segwitFeeCalculator(inputs, outputs, byteFee);

    default:
      return _defaultFeeCalculator(inputs, outputs, byteFee);
  }
}
