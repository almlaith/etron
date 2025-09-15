import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:etron_flutter/api/api_client.dart';
import 'package:etron_flutter/models/api_response.dart';
import 'package:etron_flutter/services/storage_service.dart';

class UserService {
  static Future<ApiResponse<Map<String, dynamic>>> getUserProfileById(String userLoginId) {
    return ApiClient.get(ApiClient.userProfileEndpoint, queryParams: {'userLoginId': userLoginId});
  }

  static Future<ApiResponse<Map<String, dynamic>>> updatePhoneNumber({
    required String newPhone,
    required String password,
  }) {
    final body = {
      'phoneNumber': newPhone,
      'currentPassword': password,
    };
    return ApiClient.put(ApiClient.resetPhoneEndpoint, body: body);
  }

  static Future<Map<String, dynamic>?> getMyProfile() async {
    final id = await _getUserLoginIdFromStorageOrJwt();
    if (id == null || id.isEmpty) return null;
    final response = await getUserProfileById(id);
    if (response.success && response.data?['data'] is Map) {
      return Map<String, dynamic>.from(response.data!['data'] as Map);
    }
    return null;
  }

  static Future<String?> getDisplayNameFromProfile() async {
    final data = await getMyProfile();
    if (data == null) return null;

    final name = (data['name'] as String?)?.trim();
    if (name != null && name.isNotEmpty) return name;

    final mail = (data['userEmail'] as String?)?.trim();
    if (mail != null && mail.isNotEmpty) return mail;

    final phone = (data['phoneNumber'] as String?)?.trim();
    if (phone != null && phone.isNotEmpty) return phone;

    return null;
  }


  static Future<ApiResponse<Map<String, dynamic>>> deleteAccount() async {
    final userId = await StorageService.getUserLoginId();

    if (userId == null || userId.isEmpty) {
      return ApiResponse(
        success: false,
        statusCode: 400,
        message: 'User ID not found. Please log in again.',
      );
    }

    final body = {
      'userLoginId': userId,
    };

    final response = await ApiClient.post(
      ApiClient.deleteUserEndpoint,
      body: body,
      useAuthToken: true,
    );

    return response;
  }


  static Future<String?> _getUserLoginIdFromStorageOrJwt() async {
    final stored = await StorageService.getUserLoginId();
    if (kDebugMode) debugPrint('[PROFILE] stored userLoginId=$stored');
    if (stored != null && stored.isNotEmpty) return stored;

    final sub = await _userLoginIdFromJwt();
    if (sub != null && sub.isNotEmpty) {
      await StorageService.saveUserLoginId(sub);
      if (kDebugMode) debugPrint('[PROFILE] saved userLoginId from JWT sub=$sub');
      return sub;
    }
    if (kDebugMode) debugPrint('[PROFILE][WARN] No userLoginId found (storage/JWT)');
    return null;
  }

  static Future<String?> _userLoginIdFromJwt() async {
    final at = await StorageService.getAccessToken();
    if (at == null || at.isEmpty) return null;
    final payload = _decodeJwtPayload(at);
    final sub = payload?['sub']?.toString();
    if (kDebugMode) debugPrint('[JWT] sub from accessToken = $sub');
    return sub;
  }

  static Map<String, dynamic>? _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final normalized = base64Url.normalize(parts[1]);
      final payload = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(payload);
      return (map is Map<String, dynamic>) ? map : null;
    } catch (e) {
      if (kDebugMode) debugPrint('[JWT][ERR] $e');
      return null;
    }
  }
}