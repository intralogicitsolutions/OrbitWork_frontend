class ChipData {
  final String label;
  final int count;

  ChipData(this.label, this.count);

  String get displayText => '$label ($count)';
}