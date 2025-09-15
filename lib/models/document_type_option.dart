 import 'package:meta/meta.dart';

@immutable
class DocumentTypeOption {
  final int id;
  final String label;
   final int level;

  const DocumentTypeOption({
    required this.id,
    required this.label,
    required this.level,
  });

   factory DocumentTypeOption.fromJson(Map<String, dynamic> j) {
    final idAny = j['documentTypeId'] ?? j['id'] ?? j['value'];
    final id = (idAny is num)
        ? idAny.toInt()
        : int.tryParse(idAny?.toString() ?? '') ?? 0;

     final nameObj = j['name'];
    String label;
    if (nameObj is Map) {
      label = (nameObj['en'] ?? nameObj['ar'] ?? '').toString();
    } else {
      label = (nameObj ?? '').toString();
    }

    final levelAny = j['documentLevel'] ?? j['documentLevelId'] ?? 0;
    final level = (levelAny is num)
        ? levelAny.toInt()
        : int.tryParse(levelAny.toString()) ?? 0;

    return DocumentTypeOption(id: id, label: label, level: level);
  }
}
