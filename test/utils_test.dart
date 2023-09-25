import 'package:sio_core_light/sio_core_light.dart';
import 'package:test/test.dart';

void main() {
  group('Utils - ', () {
    test('Test BigInt into list of bytes conversion', () {
      expect(bigIntToBytes(BigInt.parse('100')), [100]);
      expect(bigIntToBytes(BigInt.parse('1000')), [3, 232]);
      expect(bigIntToBytes(BigInt.parse('10000')), [39, 16]);
      expect(bigIntToBytes(BigInt.parse('100000')), [1, 134, 160]);
      expect(bigIntToBytes(BigInt.parse('1000000')), [15, 66, 64]);
      expect(bigIntToBytes(BigInt.parse('10000000')), [152, 150, 128]);
      expect(bigIntToBytes(BigInt.parse('100000000')), [5, 245, 225, 0]);
      expect(bigIntToBytes(BigInt.parse('1000000000')), [59, 154, 202, 0]);
      expect(bigIntToBytes(BigInt.parse('10000000000')), [2, 84, 11, 228, 0]);
      expect(bigIntToBytes(BigInt.parse('100000000000')), [23, 72, 118, 232, 0]);
    });
  });
}
