import 'package:test/test.dart';
import 'package:sio_core_light/sio_core_light.dart';

void main() {
  group('Mnemonic tests - ', () {
    const mnemonic12Words =
        'rent craft script crucial item someone dream federal notice page shrug pipe young hover duty';
    const mnemonic24Words =
        'trouble sand fringe fox spatial film attract domain biology exchange twist audit nose raccoon steel warrior arrest nut card skirt uniform super make gloom';
    test('Mnemonic of 12 words is valid', () {
      expect(Mnemonic.isValid(mnemonic: mnemonic12Words), equals(true));
    });
    test('Mnemonic of 24 words is valid', () {
      expect(Mnemonic.isValid(mnemonic: mnemonic24Words), equals(true));
    });
    test('Generated mnemonic has 12 words', () {
      expect(Mnemonic().generate.split(' ').length, equals(12));
    });
    test('Import 12 seed mnemonic', () {
      expect(Mnemonic.import(mnemonic: mnemonic12Words).mnemonic(), equals(mnemonic12Words));
    });
    test('Import 24 seed mnemonic', () {
      expect(Mnemonic.import(mnemonic: mnemonic24Words).mnemonic(), equals(mnemonic24Words));
    });
  });
}
