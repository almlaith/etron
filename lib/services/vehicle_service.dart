  import 'package:etron_flutter/api/api_client.dart';
  import 'package:etron_flutter/models/api_response.dart';
  import 'package:etron_flutter/models/vehicle_model.dart';
  import 'package:etron_flutter/models/vehicle_profile_model.dart';
  
  class VehicleService {
    static Future<ApiResponse<Map<String, dynamic>>> addCar(AddVehicleRequest req) {
      return ApiClient.post(ApiClient.carsAddEndpoint, body: req.toJson());
    }
  
    static Future<List<UserVehicle>> getUserCars({String? locale}) async {
      final response = await ApiClient.get(
        ApiClient.carsListEndpoint,
        locale: locale,
      );
  
      if (response.success && response.data?['data'] is List) {
        final List<dynamic> carListJson = response.data!['data'];
        return carListJson.map((json) => UserVehicle.fromJson(json)).toList();
      }
      return [];
    }
  
    static Future<CarProfile?> getCarProfile(String carId, {String? locale}) async {
      final response = await ApiClient.post(
        ApiClient.carsProfileEndpoint,
        body: {'id': carId},
        locale: locale,
      );
      if (response.success && response.data?['data'] is Map<String, dynamic>) {
        return CarProfile.fromJson(response.data!['data']);
      }
      return null;
    }
  
    static Future<bool> checkUserHasCar() async {
      final response = await ApiClient.get(ApiClient.carCheckEndpoint);
      if (response.success && response.data != null) {
        final data = response.data!['data'] as Map<String, dynamic>?;
        if (data != null && data.containsKey('car')) {
          return data['car'] as bool;
        }
      }
      return true;
    }
  }
