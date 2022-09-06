import 'package:convert/convert.dart';

/// Converts BigInt numbers into list of bytes.
///
/// Example:
/// * `12345678910111213141516171819202122232425 is converted to
/// [36, 71, 219, 69, 9, 146, 148, 96, 119, 231, 69, 190, 155, 124, 198, 50, 105]`
List<int> bigIntToBytes(BigInt number) {
  var inHex = number.toRadixString(16);
  if (inHex.length % 2 == 1) {
    inHex = '0$inHex';
  }
  return hex.decode(inHex);
}
