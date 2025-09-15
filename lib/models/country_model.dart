class CountryModel {
  final String countryCode;
  final String title;
  final String? dialCode;

  CountryModel({
    required this.countryCode,
    required this.title,
    this.dialCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryCode: json['countryCode'] ?? '',
      title: json['title'] ?? '',
      dialCode: json['dialCode'],
    );
  }
}
