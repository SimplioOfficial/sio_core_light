#!/bin/sh

fvm flutter pub get

# Off emulator tests
fvm flutter test test

# On emulator tests
cd example
fvm flutter test integration_tests/on_emulator_test.dart
