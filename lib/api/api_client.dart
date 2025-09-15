import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart' as mime;

import '../models/api_response.dart';
import '../services/storage_service.dart';

class ApiClient {
  // static const String _baseUrl = 'https://stgapi.etron-mena.com/';
  static const String _baseUrl = 'http://10.0.2.2:9501/';
  static const String _gatewayBaseUrl = 'https://gwstg.mzn.dev/v1/';

  // User & Auth
  static const String loginEndpoint = 'user/login';
  static const String logoutEndpoint = 'user/logout';
  static const String signupEndpoint = 'user/create';
  static const String deleteUserEndpoint = 'user/delete';
  static const String signupAuthVerifyEndpoint = 'user/create/auth-verify';
  static const String userProfileEndpoint = 'user/profile';
  static const String changePasswordEndpoint = 'user/password/change';
  static const String resetPhoneEndpoint = 'user/reset/phone';
  static const String forgotPasswordEndpoint = 'user/reset-password';
  static const String forgotPasswordCheckPhoneEndpoint = 'user/reset-password/check-phone';
  static const String carCheckEndpoint = 'car/check';
  // Vehicle
  static const String carsAddEndpoint = 'cars/add';
  static const String carsListEndpoint = 'cars/list';
  static const String carsProfileEndpoint = 'cars/profile';

  // Documents
  static const String documentTypesEndpoint = 'document/type/list';
  static const String documentAddEndpoint = 'document/add';
  static const String documentUpdateEndpoint = 'document/update';
  static const String docsGroupEndpoint = 'document/car/list';
  static const String attachmentDownloadEndpoint = 'attachment/download';

  // Common
  static const String countrySelectEndpoint = 'common/country-select';
  static const String chargerTypeSelectEndpoint = 'charger-types';

  // Gateway (absolute)
  static const String visitorPhoneRegister = 'visitor-phone/register';
  static const String formatPhoneEndpoint = '${_gatewayBaseUrl}common/mobile/format';
  static const String countriesEndpoint = '${_gatewayBaseUrl}common/countries';
  static const String otpSmsCreateEndpoint = '${_gatewayBaseUrl}otp/sms/create';
  static const String otpCheckEndpoint = '${_gatewayBaseUrl}otp/check';

  static String buildAttachmentUrl(String documentId) {
    final uri = Uri.parse('$_baseUrl$attachmentDownloadEndpoint')
        .replace(queryParameters: {'id': documentId});
    return uri.toString();
  }

  static String get _gatewayToken =>
      dotenv.env['BEARER_TOKEN_MZN_GATEWAY'] ?? '';

  static String _normLocale(String? locale) {
    final l = (locale ?? '').toLowerCase();
    if (l.startsWith('ar')) return 'ar';
    return 'en';
  }

  static Future<Map<String, String>> _getHeaders({
    bool useAuthToken = true,
    bool isGateway = false,
    String? locale,
  }) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (isGateway) {
      headers['Authorization'] = 'Bearer $_gatewayToken';
    } else if (useAuthToken) {
      final at = await StorageService.getAccessToken();
      if (at != null && at.isNotEmpty) {
        headers['Authorization'] = 'Bearer $at';
      }
    }

    if (locale != null && locale.isNotEmpty) {
      final norm = _normLocale(locale);
      headers['Accept-Language'] = norm;
      headers['User-Lang'] = norm;
    }

    return headers;
  }

  static Future<Map<String, String>> _getMultipartHeaders({String? locale}) async {
    final at = await StorageService.getAccessToken();
    final headers = <String, String>{
      'Accept': 'application/json',
      if (at != null && at.isNotEmpty) 'Authorization': 'Bearer $at',
    };
    if (locale != null && locale.isNotEmpty) {
      final norm = _normLocale(locale);
      headers['Accept-Language'] = norm;
      headers['User-Lang'] = norm;
    }
    return headers;
  }

  static ApiResponse<Map<String, dynamic>> _successEmpty(http.Response res) {
    return ApiResponse<Map<String, dynamic>>(
      success: res.statusCode >= 200 && res.statusCode < 300,
      statusCode: res.statusCode,
      data: const {},
      message: res.reasonPhrase,
    );
  }

  static ApiResponse<Map<String, dynamic>> _safeDecode(http.Response res) {
    try {
      if ((res.body).trim().isEmpty) {
        return _successEmpty(res);
      }

      final decoded = jsonDecode(res.body);
      if (decoded is Map<String, dynamic>) {
        final hasFlag = decoded.containsKey('success') ||
            decoded.containsKey('isValid') ||
            decoded.containsKey('valid');
        final success = decoded['success'] == true ||
            decoded['isValid'] == true ||
            decoded['valid'] == true ||
            (!hasFlag && (res.statusCode >= 200 && res.statusCode < 300));

        return ApiResponse(
          success: success,
          statusCode: res.statusCode,
          data: decoded,
          message: (decoded['message'] ?? decoded['error'] ?? res.reasonPhrase)?.toString(),
        );
      }

      return ApiResponse(
        success: res.statusCode >= 200 && res.statusCode < 300,
        statusCode: res.statusCode,
        data: {'data': decoded},
        message: res.reasonPhrase,
      );
    } catch (_) {
      return ApiResponse(
        success: false,
        statusCode: res.statusCode,
        data: {'body': res.body},
        message: res.reasonPhrase ?? 'Failed to decode response.',
      );
    }
  }

  // Public HTTP Methods

  static Future<ApiResponse<Map<String, dynamic>>> get(
      String endpoint, {
        Map<String, String>? queryParams,
        bool useAuthToken = true,
        String? locale,
      }) async {
    final url = Uri.parse('$_baseUrl$endpoint')
        .replace(queryParameters: queryParams);
    if (kDebugMode) debugPrint('[GET] $url');

    final headers = await _getHeaders(
      useAuthToken: useAuthToken,
      locale: locale,
    );

    final res = await http.get(url, headers: headers);
    return _safeDecode(res);
  }

  static Future<ApiResponse<Map<String, dynamic>>> post(
      String endpoint, {
        required Map<String, dynamic> body,
        bool useAuthToken = true,
        bool isGateway = false,
        bool absoluteUrl = false,
        String? locale,
      }) async {
    final url = absoluteUrl
        ? Uri.parse(endpoint)
        : Uri.parse('$_baseUrl$endpoint');

    if (kDebugMode) debugPrint('[POST] $url');

    final headers = await _getHeaders(
      useAuthToken: useAuthToken,
      isGateway: isGateway,
      locale: locale,
    );

    final res = await http.post(url, headers: headers, body: jsonEncode(body));
    return _safeDecode(res);
  }

  static Future<ApiResponse<Map<String, dynamic>>> put(
      String endpoint, {
        required Map<String, dynamic> body,
        bool useAuthToken = true,
        String? locale,
      }) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    if (kDebugMode) debugPrint('[PUT] $url');

    final headers = await _getHeaders(useAuthToken: useAuthToken, locale: locale);

    final res = await http.put(url, headers: headers, body: jsonEncode(body));
    return _safeDecode(res);
  }

  static Future<ApiResponse<Map<String, dynamic>>> multipartPost(
      String endpoint, {
        required Map<String, String> fields,
        required File file,
        String? locale,
      }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    if (kDebugMode) debugPrint('[MULTIPART][POST] $uri');

    final req = http.MultipartRequest('POST', uri);
    req.headers.addAll(await _getMultipartHeaders(locale: locale));
    req.fields.addAll(fields);

    final fileName = file.path.split(Platform.pathSeparator).last;
    final mimeType = mime.lookupMimeType(file.path) ?? 'application/octet-stream';
    final mediaType = MediaType.parse(mimeType);

    req.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: fileName,
      contentType: mediaType,
    ));

    final streamedRes = await req.send();
    final res = await http.Response.fromStream(streamedRes);
    if (kDebugMode) {
      debugPrint('[UPLOAD][STATUS] ${res.statusCode}');
      debugPrint('[UPLOAD][RESP] ${res.body}');
    }
    return _safeDecode(res);
  }
}
