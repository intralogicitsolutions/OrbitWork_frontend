enum TransactionType {
  gst,
  serviceFee,
  wht,
  hourly,
}

extension TransactionTypeExtension on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.gst:
        return 'GST';
      case TransactionType.serviceFee:
        return 'Service Fee';
      case TransactionType.wht:
        return 'WHT';
      case TransactionType.hourly:
        return 'Hourly';
    }
  }
}
