import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Address {
  static bool isValid({
    required String address,
    required int networkId,
  }) {
    return AnyAddress.isValid(address, networkId);
  }
}
