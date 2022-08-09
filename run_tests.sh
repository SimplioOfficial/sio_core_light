#!/bin/sh

flutter pub get

# Off emulator tests
flutter test

# On emulator tests
flutter test integration_test
