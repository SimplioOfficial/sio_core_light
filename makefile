clean:
	fvm flutter clean

install:
	fvm flutter pub get

analyze:
	fvm dart analyze

format:
	fvm dart format .

tests:
	fvm flutter test

integration-tests:
	cd example && fvm flutter test integration_tests/on_emulator_test.dart

dependency_check:
	fvm flutter pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides

