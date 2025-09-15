import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class CarDocument {
  final String documentId;
  final String name;
  final String? startDate;
  final String? endDate;
  final int actualVersion;
  final String? documentNumber;
  final String groupId;

  CarDocument({
    required this.documentId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.actualVersion,
    required this.documentNumber,
    required this.groupId,
  });

  factory CarDocument.fromJson(Map<String, dynamic> j) {
    return CarDocument(
      documentId: j['document_id']?.toString() ?? '',
      name: j['name']?.toString() ?? '',
      startDate: j['start_date']?.toString(),
      endDate: j['end_date']?.toString(),
      actualVersion: (j['actual_version'] is num)
          ? (j['actual_version'] as num).toInt()
          : int.tryParse('${j['actual_version']}') ?? 1,
      documentNumber: j['document_number']?.toString(),
      groupId: j['group_id']?.toString() ?? '',
    );
  }

  String prettyDate(String? s) => (s == null || s.isEmpty) ? '-' : s;

  String get versionLabel => 'v$actualVersion';

  static const badgeStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
}
