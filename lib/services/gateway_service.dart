import 'package:etron_flutter/api/api_client.dart';
import 'package:etron_flutter/models/api_response.dart';

class GatewayService {
  static Future<bool> registerVisitorPhone(String phone) async {
    try {
      final response = await ApiClient.post(
        ApiClient.visitorPhoneRegister,
        body: {'phoneNumber': phone},
        useAuthToken: false,
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<String?> formatPhone(String cc, String number) async {
    final response = await ApiClient.post(
      ApiClient.formatPhoneEndpoint,
      body: {'countryCode': cc.toLowerCase(), 'number': number},
      absoluteUrl: true,
      useAuthToken: false,
    );
    if (response.success && response.data != null) {
      final data = response.data!;
      return data['isValid'] == true ? data['formattedNumber'] : null;
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> fetchCountries({
    required String locale,
    String query = '',
  }) async {
    final response = await ApiClient.post(
        ApiClient.countriesEndpoint,
        body: {'pageSize': 195, 'pageNumber': 1, 'searchQuery': query, 'language': locale},
        absoluteUrl: true,
        useAuthToken: false,
        locale: locale
    );
    if (response.success && response.data?['rows'] is List) {
      final rows = (response.data!['rows']) as List;
      return rows.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<ApiResponse<Map<String, dynamic>>> sendOtp({
    required String phone,
    int length = 4,
    int duration = 300,
  }) {
    return ApiClient.post(
      ApiClient.otpSmsCreateEndpoint,
      body: {'length': length, 'mobile': phone.replaceFirst('+', ''), 'duration': duration},
      isGateway: true,
      absoluteUrl: true,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> verifyOtp({
    required String key,
    required String otp,
    String? mobile,
  }) async {
    final payload = {
      'key': key,
      'code': otp,
      if (mobile != null) 'mobile': mobile.replaceFirst('+', ''),
    };

    final response = await ApiClient.post(
      ApiClient.otpCheckEndpoint,
      body: payload,
      isGateway: true,
      absoluteUrl: true,
    );

    final data = response.data ?? <String, dynamic>{};
    final ok = data['isValid'] == true ||
        data['valid'] == true ||
        data['success'] == true;

    return ApiResponse(
        success: ok,
        statusCode: response.statusCode,
        data: {...data, 'isValid': ok},
        message: response.message
    );
  }
}