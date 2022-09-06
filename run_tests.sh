#!/bin/sh

flutter pub get

# Off emulator tests
flutter test

# On emulator tests
cd example
flutter test integration_tests
