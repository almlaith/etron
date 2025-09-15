import 'dart:io';
import 'package:etron_flutter/api/api_client.dart';
import 'package:etron_flutter/models/api_response.dart';
import 'package:etron_flutter/models/car_document.dart';
import 'package:etron_flutter/models/document_type_option.dart';

class DocumentService {
  static Future<List<DocumentTypeOption>> selectDocumentTypes({
    String? locale,
    String targetType = 'CAR',
  }) async {
    final level = (targetType == 'STATION') ? 1 : 2;
    final response = await ApiClient.post(
      ApiClient.documentTypesEndpoint,
      body: {'documentLevel': level},
      locale: locale,
    );

    if (response.success && response.data?['data'] is List) {
      final data = response.data!['data'] as List;
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => DocumentTypeOption.fromJson(e))
          .toList();
    }

    final fallback = [
      {"documentTypeId": 6, "documentLevel": 2, "name": {"ar": "رخصة سيارة", "en": "vehicle License"}}
    ];

    return fallback.map((e) => DocumentTypeOption.fromJson(e)).where((e) => e.level == level).toList();
  }

  // --- START MODIFICATION ---
  static Future<List<CarDocument>> getCarDocuments(String carId, {String? locale}) async {
    final body = {
      'id': carId,
      'table': {'pageSize': 200, 'pageNumber': 1, 'searchQuery': '', 'filters': [], 'sorts': []}
    };
    final response = await ApiClient.post(ApiClient.docsGroupEndpoint, body: body, locale: locale);

    final rows = (response.data?['rows'] ?? response.data?['data']?['rows'] ?? []) as List;
    return rows.map((e) => CarDocument.fromJson(Map<String, dynamic>.from(e))).toList();
  }
  // --- END MODIFICATION ---

  static Future<ApiResponse<Map<String, dynamic>>> uploadCarDocument({
    required String carId,
    required int documentTypeId,
    required String documentNumber,
    required String startDate,
    required String endDate,
    required File file,
  }) {
    final fields = {
      'targetType': 'CAR',
      'targetId': carId,
      'documentTypeId': documentTypeId.toString(),
      'documentNumber': documentNumber,
      'startDate': startDate,
      'endDate': endDate,
    };
    return ApiClient.multipartPost(ApiClient.documentAddEndpoint, fields: fields, file: file);
  }

  static Future<bool> uploadCarDocumentVersion({
    required String carId,
    required String groupId,
    required String documentNumber,
    required String endDate,
    required File file,
  }) async {
    final fields = {
      'targetType': 'CAR',
      'targetId': carId,
      'groupId': groupId,
      'documentNumber': documentNumber,
      'endDate': endDate,
    };
    final response = await ApiClient.multipartPost(ApiClient.documentUpdateEndpoint, fields: fields, file: file);
    return response.success;
  }

  static String buildAttachmentDownloadUrl(String documentId) {
    return ApiClient.buildAttachmentUrl(documentId);
  }
}