import 'package:etron_flutter/api/api_client.dart';
import 'package:etron_flutter/models/select_option.dart';
import 'package:etron_flutter/models/vehicle_model.dart';

class CommonService {
  static Future<List<SelectOption>> selectCountries({
    String query = '',
    String? locale,
  }) async {
    final body = {
      'pageSize': 200,
      'pageNumber': 1,
      'searchQuery': query,
      'filters': [],
      'sorts': [],
    };
    final response = await ApiClient.post(
        ApiClient.countrySelectEndpoint,
        body: body,
        locale: locale
    );
    final rows = (response.data?['rows'] ?? response.data?['data']?['rows'] ?? []) as List;
    return rows.cast<Map<String, dynamic>>().map((e) => SelectOption.fromJson(e)).toList();
  }

  static Future<List<ChargerTypeOption>> selectChargerTypes({String? locale}) async {
    final response = await ApiClient.get(ApiClient.chargerTypeSelectEndpoint, locale: locale);

    List items = [];
    if (response.success && response.data != null) {
      final data = response.data!;
      if (data['data'] is List) {
        items = data['data'];
      } else if (data['rows'] is List) {
        items = data['rows'];
      } else if (data is List) {
        items = data as List;
      }
    }

    String normalizeType(String raw, String name) {
      final t = (raw).toString().toUpperCase().trim();
      if (t == 'AC' || t == 'DC' || t == 'AC/DC') return t;

      final ln = name.toLowerCase();
      final hasAc = ln.contains('ac') || ln.contains('mennekes') || ln.contains('type 1') || ln.contains('type 2');
      final hasDc = ln.contains('dc') || ln.contains('ccs') || ln.contains('chademo') || ln.contains('tesla');

      if (hasAc && hasDc) return 'AC/DC';
      if (hasAc) return 'AC';
      if (hasDc) return 'DC';
      return '';
    }

    String pickLabel(dynamic nameObj) {
      if (nameObj is Map) return (nameObj['en'] ?? nameObj['ar'] ?? '').toString();
      return (nameObj ?? '').toString();
    }

    final list = <ChargerTypeOption>[];
    for (final it in items) {
      if (it is! Map) continue;
      final idAny = it['chargerTypeId'] ?? it['id'] ?? it['value'];
      if (idAny == null) continue;
      final id = (idAny as num).toInt();
      final label = pickLabel(it['name']);
      final type = normalizeType(it['type'] ?? '', label);
      list.add(ChargerTypeOption(id: id, label: label, type: type));
    }

    return list;
  }
}