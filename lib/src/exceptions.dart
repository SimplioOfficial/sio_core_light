// Specific exceptions are defined so application can
// respond differently to each case.

/// Current address has no utxo available.
class NoUtxoAvailableException implements Exception {
  const NoUtxoAvailableException();
  @override
  String toString() =>
      'NoUtxoAvailableException: Current address has no utxo available.';
}

/// Total amount in the address is lower than the amount
/// that is wanted to be sent plus the transaction fee
/// needed to execute this transaction.
///
/// Try to lower the amount to be sent.
class LowTotalAmountPlusFeeException implements Exception {
  const LowTotalAmountPlusFeeException();
  @override
  String toString() => 'LowTotalAmountPlusFeeException: '
      'Total amount in the address is lower than the amount that is wanted to '
      'be send plus the transaction fee needed to execute this transaction. '
      'Try to lower the amount to be sent.';
}
