// // lib/api/api_service.dart
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart' as mime;
//
// import '../models/vehicle/document/car_document.dart';
// import '../models/vehicle/document/document_type_option.dart';
// import '../models/vehicle/vehicle_model.dart';
// import '../models/vehicle/vehicle_profile_model.dart';
// import '../models/select_option.dart';
// import '../services/storage_service.dart';
//
// class ApiService {
//   // static const String _baseUrl = 'https://stgapi.etron-mena.com/';
//   static const String _baseUrl = 'http://10.0.2.2:9501/';
//
//
//   static const String loginEndpoint                  = 'user/login';
//   static const String logoutEndpoint                 = 'user/logout';
//   static const String signupEndpoint                 = 'user/create';
//   static const String resetPhoneEndpoint             = 'user/reset/phone';
//   static const String userProfileEndpoint            = 'user/profile';
//   static const String visitorPhoneRegister           = 'visitor-phone/register';
//   static const String forgotPasswordEndpoint         = 'user/reset-password';
//   static const String forgotPasswordCheckPhoneEndpoint = 'user/reset-password/check-phone';
//   static const String changePasswordEndpoint         = 'user/password/change';
//   static const String signupAuthVerifyEndpoint       = 'user/create/auth-verify';
//   static const String carsAddEndpoint                = 'cars/add';
//   static const String carsListEndpoint               = 'cars/list';
//   static const String countrySelectEndpoint          = 'common/country-select';
//   static const String chargerTypeSelectEndpoint      = 'charger-types';
//   static const String carsProfileEndpoint            = 'cars/profile';
//
//    static const String documentTypesEndpoint          = 'document/type/list';
//   static const String documentAddEndpoint            = 'document/add';
//   static const String documentUpdateEndpoint         = 'document/update';
//   static const String docsGroupEndpoint              = 'docs/group';
//
//   // Attachments
//   // static const String attachmentDownloadEndpoint     = 'attachment/download';
//   static const String attachmentDownloadEndpoint = 'attachment/download';
//
//   // Gateway
//   static const String formatPhoneEndpoint  = 'https://gwstg.mzn.dev/v1/common/mobile/format';
//   static const String countriesEndpoint    = 'https://gwstg.mzn.dev/v1/common/countries';
//   static const String otpSmsCreateEndpoint = 'https://gwstg.mzn.dev/v1/otp/sms/create';
//   static const String otpCheckEndpoint     = 'https://gwstg.mzn.dev/v1/otp/check';
//
//   static String get _token => dotenv.env['BEARER_TOKEN_MZN_GATEWAY'] ?? '';
//
//   static Map<String, String> _headers([bool auth = true]) => {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     if (auth) 'Authorization': 'Bearer $_token',
//   };
//
//   static Map<String, String> _headersNoAuth() => {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//   };
//
//   // accessToken  (JWT /user/login)
//   static Future<Map<String, String>> _userHeaders() async {
//     final at = await StorageService.getAccessToken();
//     return {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       if (at != null && at.isNotEmpty) 'Authorization': 'Bearer $at',
//     };
//   }
//
//   static Future<Map<String, String>> _userHeadersMultipart() async {
//     final at = await StorageService.getAccessToken();
//     return {
//       'Accept': 'application/json',
//       if (at != null && at.isNotEmpty) 'Authorization': 'Bearer $at',
//     };
//   }
//
//   static Map<String, dynamic> _safeDecode(http.Response res) {
//     try {
//       final decoded = jsonDecode(res.body);
//       if (decoded is Map<String, dynamic>) {
//         return {
//           ...decoded,
//           'statusCode': res.statusCode,
//         };
//       }
//       return {'success': false, 'data': decoded, 'statusCode': res.statusCode};
//     } catch (_) {
//       return {
//         'success': false,
//         'statusCode': res.statusCode,
//         'body': res.body,
//         'message': res.reasonPhrase,
//       };
//     }
//   }
//
//   static Future<Map<String, dynamic>> _post(
//       String uri, {
//         required Map<String, dynamic> body,
//         bool absolute = false,
//       }) async {
//     final url = absolute ? Uri.parse(uri) : Uri.parse('$_baseUrl$uri');
//     if (kDebugMode) debugPrint('[POST] $url');
//     final res = await http.post(url, headers: _headers(), body: jsonEncode(body));
//     return _safeDecode(res);
//   }
//
//   static Future<Map<String, dynamic>> _postCreateAccount(
//       String uri, {
//         required Map<String, dynamic> body,
//         bool absolute = false,
//       }) async {
//     final url = absolute ? Uri.parse(uri) : Uri.parse('$_baseUrl$uri');
//     if (kDebugMode) debugPrint('[POST] $url');
//     final res = await http.post(url, headers: _headersNoAuth(), body: jsonEncode(body));
//     return _safeDecode(res);
//   }
//
//
//   static Future<List<Map<String, dynamic>>> _postSelect(
//       String uri, {
//         String query = '',
//         String? locale,
//         List<Map<String, dynamic>>? filters,
//         List<Map<String, dynamic>>? sorts,
//         int pageSize = 200,
//         int pageNumber = 1,
//       }) async {
//     final url = Uri.parse('$_baseUrl$uri');
//     if (kDebugMode) debugPrint('[POST] $url');
//
//     final headers = await _userHeaders();
//     if (locale != null && locale.isNotEmpty) {
//       headers['Accept-Language'] = locale;
//       headers['User-Lang'] = locale;
//     }
//
//     final res = await http.post(
//       url,
//       headers: headers,
//       body: jsonEncode({
//         'pageSize': pageSize,
//         'pageNumber': pageNumber,
//         'searchQuery': query,
//         'filters': filters ?? [],
//         'sorts': sorts ?? [],
//       }),
//     );
//
//     final body = _safeDecode(res);
//     final rows = (body['rows'] ?? body['data']?['rows'] ?? []) as List;
//     return rows.cast<Map<String, dynamic>>();
//   }
//
//
//   static Future<List<ChargerTypeOption>> selectChargerTypes({String? locale}) async {
//     final url = Uri.parse('$_baseUrl$chargerTypeSelectEndpoint');
//     if (kDebugMode) debugPrint('[GET] $url');
//
//     final headers = await _userHeaders();
//     if (locale != null && locale.isNotEmpty) {
//       headers['User-Lang'] = locale;
//       headers['Accept-Language'] = locale;
//     }
//
//     final res = await http.get(url, headers: headers);
//     final body = _safeDecode(res);
//
//     List items = [];
//     if (body is List) {
//       items = body as List;
//     } else if (body is Map) {
//       if (body['data'] is List) {
//         items = body['data'];
//       } else if (body['rows'] is List) {
//         items = body['rows'];
//       }
//     }
//
//     String normalizeType(String raw, String name) {
//       final t = (raw).toString().toUpperCase().trim();
//       if (t == 'AC' || t == 'DC' || t == 'AC/DC') return t;
//
//       final ln = name.toLowerCase();
//       final hasAc = ln.contains('ac') || ln.contains('mennekes') || ln.contains('type 1') || ln.contains('type 2');
//       final hasDc = ln.contains('dc') || ln.contains('ccs') || ln.contains('chademo') || ln.contains('tesla');
//
//       if (hasAc && hasDc) return 'AC/DC';
//       if (hasAc) return 'AC';
//       if (hasDc) return 'DC';
//       return '';
//     }
//
//     String pickLabel(dynamic nameObj) {
//       if (nameObj is Map) return (nameObj['en'] ?? nameObj['ar'] ?? '').toString();
//       return (nameObj ?? '').toString();
//     }
//
//     final list = <ChargerTypeOption>[];
//     for (final it in items) {
//       if (it is! Map) continue;
//
//       final idAny = it['chargerTypeId'] ?? it['id'] ?? it['value'];
//       if (idAny == null) continue;
//       final id = (idAny as num).toInt();
//
//       final label = pickLabel(it['name']);
//       final type = normalizeType(it['type'] ?? '', label);
//
//       list.add(ChargerTypeOption(id: id, label: label, type: type));
//     }
//
//     return list;
//   }
//
//   static Future<Map<String, dynamic>?> _postAuth(String uri, Map<String, dynamic> body) async {
//     final url = Uri.parse('$_baseUrl$uri');
//     final res = await http.post(url, headers: await _userHeaders(), body: jsonEncode(body));
//     final decoded = _safeDecode(res);
//     return decoded;
//   }
//
//   static Future<CarProfile?> getCarProfile(String carId) async {
//     final payload = {'id': carId};
//     final decoded = await _postAuth(carsProfileEndpoint, payload);
//     if (decoded == null) return null;
//     final data = decoded['data'];
//     if (data is Map<String, dynamic>) {
//       return CarProfile.fromJson(data);
//     }
//     return null;
//   }
//
//   static Future<List<Map<String, dynamic>>> _postSelectCountries(
//       String uri, {
//         String query = '',
//         String? locale,
//       }) async {
//     return _postSelect(
//       uri,
//       query: query,
//       locale: locale,
//     );
//   }
//
//   static Future<List<SelectOption>> selectCountries({
//     String query = '',
//     String? locale,
//   }) async {
//     final rows = await _postSelectCountries(
//       countrySelectEndpoint,
//       query: query,
//       locale: locale,
//     );
//     return rows.map((e) => SelectOption.fromJson(e)).toList();
//   }
//
//
//   static Future<Map<String, dynamic>> addCar(AddVehicleRequest req) async {
//     final url = Uri.parse('$_baseUrl$carsAddEndpoint');
//     if (kDebugMode) debugPrint('[POST] $url');
//     final res = await http.post(url, headers: await _userHeaders(), body: jsonEncode(req.toJson()));
//     return _safeDecode(res);
//   }
//
//   static Future<List<UserVehicle>> getUserCars() async {
//     final url = Uri.parse('$_baseUrl$carsListEndpoint');
//     if (kDebugMode) debugPrint('[GET] $url');
//     final res = await http.get(url, headers: await _userHeaders());
//     final body = _safeDecode(res);
//     if (body['success'] == true && body['data'] is List) {
//       final list = (body['data'] as List).cast<Map<String, dynamic>>();
//       return list.map((e) => UserVehicle.fromJson(e)).toList();
//     }
//     return [];
//   }
//
//   static Map<String, dynamic>? _decodeJwtPayload(String token) {
//     try {
//       final parts = token.split('.');
//       if (parts.length != 3) return null;
//       final normalized = base64Url.normalize(parts[1]);
//       final payload = utf8.decode(base64Url.decode(normalized));
//       final map = jsonDecode(payload);
//       return (map is Map<String, dynamic>) ? map : null;
//     } catch (e) {
//       if (kDebugMode) debugPrint('[JWT][ERR] $e');
//       return null;
//     }
//   }
//
//   static Future<String?> _userLoginIdFromJwt() async {
//     final at = await StorageService.getAccessToken();
//     if (at == null || at.isEmpty) return null;
//     final payload = _decodeJwtPayload(at);
//     final sub = payload?['sub']?.toString();
//     if (kDebugMode) debugPrint('[JWT] sub from accessToken = $sub');
//     return sub;
//   }
//
//   static Future<String?> _getUserLoginIdFromStorageOrJwt() async {
//     final stored = await StorageService.getUserLoginId();
//     if (kDebugMode) debugPrint('[PROFILE] stored userLoginId=$stored');
//     if (stored != null && stored.isNotEmpty) return stored;
//
//     final sub = await _userLoginIdFromJwt();
//     if (sub != null && sub.isNotEmpty) {
//       await StorageService.saveUserLoginId(sub);
//       if (kDebugMode) debugPrint('[PROFILE] saved userLoginId from JWT sub=$sub');
//       return sub;
//     }
//     if (kDebugMode) debugPrint('[PROFILE][WARN] No userLoginId found (storage/JWT)');
//     return null;
//   }
//
//   static Future<bool> registerVisitorPhone(String phone) async {
//     try {
//       final res = await http.post(
//         Uri.parse('$_baseUrl$visitorPhoneRegister'),
//         headers: _headersNoAuth(),
//         body: jsonEncode({'phoneNumber': phone}),
//       );
//       return res.statusCode == 200;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   static Future<String?> formatPhone(String cc, String number) async {
//     final res = await http.post(
//       Uri.parse(formatPhoneEndpoint),
//       headers: _headersNoAuth(),
//       body: jsonEncode({'countryCode': cc.toLowerCase(), 'number': number}),
//     );
//     if (res.statusCode == 200) {
//       final j = jsonDecode(res.body);
//       return j['isValid'] == true ? j['formattedNumber'] : null;
//     }
//     return null;
//   }
//
//   static Future<List<Map<String, dynamic>>> fetchCountries({
//     required String locale,
//     String query = '',
//   }) async {
//     final res = await http.post(
//       Uri.parse(countriesEndpoint),
//       headers: {..._headersNoAuth(), 'User-Lang': locale},
//       body: jsonEncode({
//         'pageSize': 195,
//         'pageNumber': 1,
//         'searchQuery': query,
//         'language': locale,
//       }),
//     );
//     if (res.statusCode == 200) {
//       final rows = (jsonDecode(res.body)['rows'] ?? []) as List;
//       return rows.cast<Map<String, dynamic>>();
//     }
//     return [];
//   }
//
//   static Future<Map<String, dynamic>> sendOtp({
//     required String phone,
//     int length = 4,
//     int duration = 300,
//   }) async {
//     final res = await http.post(
//       Uri.parse(otpSmsCreateEndpoint),
//       headers: _headers(),
//       body: jsonEncode({
//         'length': length,
//         'mobile': phone.replaceFirst('+', ''),
//         'duration': duration,
//       }),
//     );
//     return _safeDecode(res);
//   }
//
//   static Future<Map<String, dynamic>> verifyOtp({
//     required String key,
//     required String otp,
//     String? mobile,
//   }) async {
//     final payload = {
//       'key': key,
//       'code': otp,
//       if (mobile != null) 'mobile': mobile.replaceFirst('+', ''),
//     };
//
//     final res = await http.post(Uri.parse(otpCheckEndpoint), headers: _headers(), body: jsonEncode(payload));
//
//     final decoded = _safeDecode(res);
//     final data = (decoded['data'] is Map) ? Map<String, dynamic>.from(decoded['data']) : <String, dynamic>{};
//
//     final ok = decoded['isValid'] == true ||
//         decoded['valid'] == true ||
//         decoded['success'] == true ||
//         data['isValid'] == true ||
//         data['valid'] == true ||
//         data['success'] == true;
//
//     return {...decoded, 'isValid': ok};
//   }
//
//   static Future<Map<String, dynamic>> checkForgotPhone(String phone) async {
//     return _postCreateAccount(forgotPasswordCheckPhoneEndpoint, body: {'phone': phone});
//   }
//
//   static Future<Map<String, dynamic>> authVerifySignup(String phone) async {
//     return _post(signupAuthVerifyEndpoint, body: {'phone': phone});
//   }
//
//   static Future<Map<String, dynamic>> forgotPassword({
//     String? phone,
//     String? email,
//     required String password,
//     required String confirmPassword,
//   }) async {
//     final body = {
//       'password': password,
//       'confirmPassword': confirmPassword,
//       if (phone != null && phone.isNotEmpty) 'phone': phone,
//       if (email != null && email.isNotEmpty) 'email': email,
//     };
//     return _postCreateAccount(forgotPasswordEndpoint, body: body);
//   }
//
//   static Future<Map<String, dynamic>> login(Map<String, dynamic> b) async =>
//       _postCreateAccount(loginEndpoint, body: b);
//
//   static Future<bool> logout() async {
//     final url = Uri.parse('$_baseUrl$logoutEndpoint');
//     if (kDebugMode) debugPrint('[POST] $url');
//
//     final res = await http.post(url, headers: _headersNoAuth(), body: jsonEncode({}));
//     final body = _safeDecode(res);
//     final ok = (body['isValid'] == true) || res.statusCode == 200;
//     return ok;
//   }
//
//   static Future<Map<String, dynamic>> signup(Map<String, dynamic> b) async =>
//       _postCreateAccount(signupEndpoint, body: b);
//
//   static Future<Map<String, dynamic>?> getUserProfileById(String userLoginId) async {
//     final url = Uri.parse('$_baseUrl$userProfileEndpoint').replace(queryParameters: {'userLoginId': userLoginId});
//     if (kDebugMode) debugPrint('[GET] $url');
//
//     final res = await http.get(url, headers: await _userHeaders());
//     final body = _safeDecode(res);
//
//     final ok = body['success'] == true && body['data'] != null;
//     if (!ok) {
//       if (kDebugMode) debugPrint('[PROFILE][WARN] body=$body');
//       return null;
//     }
//
//     return Map<String, dynamic>.from(body['data'] as Map);
//   }
//
//   static Future<String?> getDisplayNameFromProfile() async {
//     final id = await _getUserLoginIdFromStorageOrJwt();
//     if (id == null || id.isEmpty) return null;
//
//     final data = await getUserProfileById(id);
//     if (data == null) return null;
//
//     final name = (data['name'] as String?)?.trim();
//     if (name != null && name.isNotEmpty) return name;
//
//     final mail = (data['userEmail'] as String?)?.trim();
//     if (mail != null && mail.isNotEmpty) return mail;
//
//     final phone = (data['phoneNumber'] as String?)?.trim();
//     if (phone != null && phone.isNotEmpty) return phone;
//
//     return null;
//   }
//
//   static Future<Map<String, dynamic>?> getMyProfile() async {
//     final id = await _getUserLoginIdFromStorageOrJwt();
//     if (id == null || id.isEmpty) return null;
//     return getUserProfileById(id);
//   }
//
//   static Future<Map<String, dynamic>> updatePhoneNumber({
//     required String newPhone,
//     required String password,
//   }) async {
//     final url = Uri.parse('$_baseUrl$resetPhoneEndpoint');
//     final res = await http.put(
//       url,
//       headers: await _userHeaders(),
//       body: jsonEncode({
//         'phoneNumber': newPhone,
//         'currentPassword': password,
//       }),
//     );
//     return _safeDecode(res);
//   }
//
//   static Future<Map<String, dynamic>> changePassword({
//     required String currentPassword,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     final url = Uri.parse('$_baseUrl$changePasswordEndpoint');
//     if (kDebugMode) debugPrint('[PUT] $url');
//     final res = await http.put(
//       url,
//       headers: await _userHeaders(),
//       body: jsonEncode({
//         'currentPassword': currentPassword,
//         'newPassword': newPassword,
//         'confirmPassword': confirmPassword,
//       }),
//     );
//     return _safeDecode(res);
//   }
//
//   static Future<List<DocumentTypeOption>> selectDocumentTypes({
//     String? locale,
//     String targetType = 'CAR',
//   }) async {
//     final level = (targetType == 'STATION') ? 1 : 2;
//
//     final url = Uri.parse('$_baseUrl$documentTypesEndpoint');
//     if (kDebugMode) debugPrint('[POST] $url');
//
//     final headers = await _userHeaders();
//     if (locale != null && locale.isNotEmpty) {
//       headers['Accept-Language'] = locale;
//       headers['User-Lang'] = locale;
//     }
//
//     final res = await http.post(
//       url,
//       headers: headers,
//       body: jsonEncode({'documentLevel': level}),
//     );
//     final body = _safeDecode(res);
//
//     final data = body['data'];
//     if (data is List) {
//       return data
//           .whereType<Map<String, dynamic>>()
//           .map((e) => DocumentTypeOption.fromJson(e))
//           .toList();
//     }
//
//
//     final fallback = [
//       {
//         "documentTypeId": 6,
//         "documentLevel": 2,
//         "name": {"ar": "رخصة سيارة", "en": "vehicle License"}
//       }
//     ];
//     return fallback.map((e) => DocumentTypeOption.fromJson(e)).where((e) => e.level == level).toList();
//   }
//
//
//   static Future<List<CarDocument>> getCarDocuments(String carId) async {
//     final url = Uri.parse('$_baseUrl$docsGroupEndpoint');
//     if (kDebugMode) debugPrint('[POST] $url');
//
//     final headers = await _userHeaders();
//     final body = {
//       'id': carId,
//       'table': {
//         'pageSize': 200,
//         'pageNumber': 1,
//         'searchQuery': '',
//         'filters': [],
//         'sorts': [],
//       }
//     };
//
//     final res = await http.post(url, headers: headers, body: jsonEncode(body));
//     final decoded = _safeDecode(res);
//
//     final rows = (decoded['rows'] ?? decoded['data']?['rows'] ?? []) as List;
//     return rows.map((e) => CarDocument.fromJson(Map<String, dynamic>.from(e))).toList();
//   }
//
//   static Future<bool> uploadCarDocumentVersion({
//     required String carId,
//     required String groupId,
//     required String documentNumber,
//     required String endDate,
//     required File file,
//   }) async {
//     final uri = Uri.parse('$_baseUrl$documentUpdateEndpoint');
//     if (kDebugMode) debugPrint('[MULTIPART][POST] $uri');
//
//     final req = http.MultipartRequest('POST', uri);
//     req.headers.addAll(await _userHeadersMultipart());
//
//     req.fields['targetType'] = 'CAR';
//     req.fields['targetId'] = carId;
//     req.fields['groupId'] = groupId;
//     req.fields['documentNumber'] = documentNumber;
//     req.fields['endDate'] = endDate;
//
//     final fileName = file.path.split(Platform.pathSeparator).last;
//     final mimeType = mime.lookupMimeType(file.path) ?? 'application/octet-stream';
//     final mediaType = MediaType.parse(mimeType);
//
//     req.files.add(await http.MultipartFile.fromPath('file', file.path, filename: fileName, contentType: mediaType));
//
//     final streamedRes = await req.send();
//     final res = await http.Response.fromStream(streamedRes);
//     final decoded = _safeDecode(res);
//     return decoded['success'] == true;
//   }
//
//
//   static Future<Map<String, dynamic>> uploadCarDocument({
//     required String carId,
//     required int documentTypeId,
//     required String documentNumber,
//     required String startDate,
//     required String endDate,
//     required File file,
//   }) async {
//     final uri = Uri.parse('$_baseUrl$documentAddEndpoint');
//     if (kDebugMode) debugPrint('[MULTIPART][POST] $uri');
//
//     final req = http.MultipartRequest('POST', uri);
//     req.headers.addAll(await _userHeadersMultipart());
//
//     req.fields['targetType'] = 'CAR';
//     req.fields['targetId'] = carId;
//     req.fields['documentTypeId'] = documentTypeId.toString();
//     req.fields['documentNumber'] = documentNumber;
//     req.fields['startDate'] = startDate;
//     req.fields['endDate'] = endDate;
//
//     final fileName = file.path.split(Platform.pathSeparator).last;
//     final mimeType = mime.lookupMimeType(file.path) ?? 'application/octet-stream';
//     final mediaType = MediaType.parse(mimeType);
//
//     req.files.add(await http.MultipartFile.fromPath('file', file.path, filename: fileName, contentType: mediaType));
//
//     final streamedRes = await req.send();
//     final res = await http.Response.fromStream(streamedRes);
//     if (kDebugMode) {
//       debugPrint('[UPLOAD][STATUS] ${res.statusCode}');
//       debugPrint('[UPLOAD][RESP] ${res.body}');
//     }
//     return _safeDecode(res);
//   }
//
//   static String buildAttachmentDownloadUrl(String documentId) {
//     // backend: /download?id={documentId}
//     final uri = Uri.parse('$_baseUrl$attachmentDownloadEndpoint').replace(queryParameters: {'id': documentId});
//     return uri.toString();
//   }
//
//
// }
