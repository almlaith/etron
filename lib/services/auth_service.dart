// lib/services/auth_service.dart
import 'package:etron_flutter/api/api_client.dart';
import 'package:etron_flutter/models/api_response.dart';

class AuthService {
  static Future<ApiResponse<Map<String, dynamic>>> login({
    required String phone,
    required String password,
  }) {
    return ApiClient.post(
      ApiClient.loginEndpoint,
      body: {'phoneNumber': phone, 'password': password},
      useAuthToken: false,
    );
  }

  /// تمرير otpKey/otpCode مع التسجيل لإثبات التحقق
  static Future<ApiResponse<Map<String, dynamic>>> signup({
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
    String? email,
    String? otpKey,
    String? otpCode,
  }) {
    final body = {
      'name': name,
      'phoneNumber': phone,
      'password': password,
      'confirmPassword': confirmPassword,
      if (email != null && email.isNotEmpty) 'email': email,
      if (otpKey != null && otpKey.isNotEmpty) 'otpKey': otpKey,
      if (otpCode != null && otpCode.isNotEmpty) 'otpCode': otpCode,
    };
    return ApiClient.post(
      ApiClient.signupEndpoint,
      body: body,
      useAuthToken: false,
    );
  }



  static Future<ApiResponse<Map<String, dynamic>>> logout() {
    return ApiClient.post(
      ApiClient.logoutEndpoint,
      body: {},
      useAuthToken: false,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> authVerifySignup(
      String phone, {
        String? email,
      }) {
    return ApiClient.post(
      ApiClient.signupAuthVerifyEndpoint,
      body: {
        'phone': phone,
        if (email != null && email.isNotEmpty) 'email': email,
      },
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> checkForgotPhone(
      String phone,
      ) {
    return ApiClient.post(
      ApiClient.forgotPasswordCheckPhoneEndpoint,
      body: {'phone': phone},
      useAuthToken: false,
    );
  }



  static Future<ApiResponse<Map<String, dynamic>>> forgotPassword({
    String? phone,
    String? email,
    required String password,
    required String confirmPassword,
  }) {
    final body = {
      'password': password,
      'confirmPassword': confirmPassword,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (email != null && email.isNotEmpty) 'email': email,
    };
    return ApiClient.post(
      ApiClient.forgotPasswordEndpoint,
      body: body,
      useAuthToken: false,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    final body = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
    return ApiClient.put(
      ApiClient.changePasswordEndpoint,
      body: body,
    );
  }
}
