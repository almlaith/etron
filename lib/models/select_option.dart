class SelectOption {
  final int value;
  final String label;
  const SelectOption({required this.value, required this.label});

  factory SelectOption.fromJson(Map<String, dynamic> j) =>
      SelectOption(value: (j['value'] as num).toInt(), label: (j['label'] ?? '').toString());
}
