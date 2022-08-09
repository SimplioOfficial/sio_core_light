package com.example.sio_core_light

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
  init {
    System.loadLibrary("TrustWalletCore")
  }
}
