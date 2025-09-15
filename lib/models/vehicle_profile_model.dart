class CarProfile {
  final String id;
  final String userCarId;

  final String name;

  final String nameAr;
  final String nameEn;

  final String plateCountry;
  final String manufacturingCountry;
  final String plateNumber;

  final String acCharger;
  final String dcCharger;

  final String? carModel;
  final String? carColor;
  final int? carManufacturingYear;

  CarProfile({
    required this.id,
    required this.userCarId,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.plateCountry,
    required this.manufacturingCountry,
    required this.plateNumber,
    required this.acCharger,
    required this.dcCharger,
    this.carModel,
    this.carColor,
    this.carManufacturingYear,
  });

  String displayName(String currentLocale) {
    if (currentLocale.startsWith('ar')) {
      if (nameAr.isNotEmpty) return nameAr;
      if (nameEn.isNotEmpty) return nameEn;
      return name;
    } else {
      if (nameEn.isNotEmpty) return nameEn;
      if (nameAr.isNotEmpty) return nameAr;
      return name;
    }
  }

  factory CarProfile.fromJson(Map<String, dynamic> json) {
    final carInfo = json['carInfo'] is Map<String, dynamic> ? json['carInfo'] as Map<String, dynamic> : <String, dynamic>{};

    return CarProfile(
      id: (json['carId'] ?? json['id'] ?? '').toString(),
      userCarId: (json['userCarId'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      nameAr: (json['nameAr'] ?? json['name_ar'] ?? '').toString(),
      nameEn: (json['nameEn'] ?? json['name_en'] ?? '').toString(),
      plateCountry: (json['plateCountry'] ?? '').toString(),
      manufacturingCountry: (json['manufacturingCountry'] ?? '').toString(),
      plateNumber: (json['plateNumber'] ?? '').toString(),
      acCharger: (json['acCharger'] ?? '').toString(),
      dcCharger: (json['dcCharger'] ?? '').toString(),
      carModel: carInfo['carModel'] as String?,
      carColor: carInfo['carColor'] as String?,
      carManufacturingYear: carInfo['carManufacturingYear'] is String
          ? int.tryParse(carInfo['carManufacturingYear'].toString())
          : carInfo['carManufacturingYear'] as int?,
    );
  }
}