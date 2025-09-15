import 'dart:convert';

class AddVehicleRequest {
  final String nameEn;
  final String nameAr;
  final int plateCountryId;
  final String plateNumber;
  final DateTime fromDate;
  final DateTime thruDate;
  final int manufacturingCountryId;

  final int? acChargerTypeId;
  final int? dcChargerTypeId;

  final int? carManufacturingYear;
  final String? carColor;
  final String? carModel;

  AddVehicleRequest({
    required this.nameEn,
    required this.nameAr,
    required this.plateCountryId,
    required this.plateNumber,
    required this.fromDate,
    required this.thruDate,
    required this.manufacturingCountryId,
    this.acChargerTypeId,
    this.dcChargerTypeId,
    this.carManufacturingYear,
    this.carColor,
    this.carModel,
  });

  Map<String, dynamic> toJson() {
    final carInfo = <String, dynamic>{};
    if (carManufacturingYear != null) carInfo['carManufacturingYear'] = carManufacturingYear;
    if (carColor != null && carColor!.isNotEmpty) carInfo['carColor'] = carColor;
    if (carModel != null && carModel!.isNotEmpty) carInfo['carModel'] = carModel;

    final map = <String, dynamic>{
      'name': {'en': nameEn, 'ar': nameAr},
      'plateCountryId': plateCountryId,
      'plateNumber': plateNumber,
      'fromDate': fromDate.toUtc().toIso8601String(),
      'thruDate': thruDate.toUtc().toIso8601String(),
      'manufacturingCountryId': manufacturingCountryId,
      'carInfo': carInfo,
    };

    if (acChargerTypeId != null) map['acChargerTypeId'] = acChargerTypeId;
    if (dcChargerTypeId != null) map['dcChargerTypeId'] = dcChargerTypeId;

    return map;
  }
}

class UserVehicle {
  final String userCarId;
  final String carId;
  final String name;

  final String nameAr;
  final String nameEn;

  final String plateCountry;
  final String manufactureCountry;
  final String plateNumber;

  final String acCharger;
  final String dcCharger;

  final DateTime? fromDate;
  final DateTime? thruDate;
  final String? carColor;

  UserVehicle({
    required this.userCarId,
    required this.carId,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.plateCountry,
    required this.manufactureCountry,
    required this.plateNumber,
    required this.acCharger,
    required this.dcCharger,
    this.fromDate,
    this.thruDate,
    this.carColor,
  });

  String displayName(String localeCode) {
    if (localeCode.startsWith('ar')) {
      if (nameAr.isNotEmpty) return nameAr;
      if (nameEn.isNotEmpty) return nameEn;
      return name;
    } else {
      if (nameEn.isNotEmpty) return nameEn;
      if (nameAr.isNotEmpty) return nameAr;
      return name;
    }
  }

  factory UserVehicle.fromJson(Map<String, dynamic> j) {
    String? color;
    final rawInfo = j['carInfo'];
    if (rawInfo != null) {
      try {
        final map = rawInfo is String ? (jsonDecode(rawInfo) as Map<String, dynamic>) : rawInfo as Map<String, dynamic>;
        color = map['carColor'] as String?;
      } catch (_) {}
    }

    return UserVehicle(
      userCarId: (j['userCarId'] ?? '').toString(),
      carId: (j['carId'] ?? '').toString(),
      name: (j['name'] ?? '').toString(),
      nameAr: (j['nameAr'] ?? j['name_ar'] ?? '').toString(),
      nameEn: (j['nameEn'] ?? j['name_en'] ?? '').toString(),
      plateCountry: (j['plateCountry'] ?? '').toString(),
      manufactureCountry: (j['manufactureCountry'] ?? '').toString(),
      plateNumber: (j['plateNumber'] ?? '').toString(),

      acCharger: (j['acCharger'] ?? '').toString(),
      dcCharger: (j['dcCharger'] ?? '').toString(),

      fromDate: j['fromDate'] != null ? DateTime.tryParse(j['fromDate'].toString()) : null,
      thruDate: j['thruDate'] != null ? DateTime.tryParse(j['thruDate'].toString()) : null,
      carColor: color,
    );
  }
}

 class ChargerTypeOption {
  final int id;
  final String label;
  final String type;
  const ChargerTypeOption({required this.id, required this.label, required this.type});
}
