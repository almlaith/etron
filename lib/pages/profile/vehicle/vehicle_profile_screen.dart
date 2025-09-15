import 'package:flutter/material.dart';
import '../../../common/button/add_vehicle_button.dart';
import '../../../common/card/group_card.dart';
import '../../../common/overlays/snackbar.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/car_document.dart';
import '../../../models/vehicle_profile_model.dart';
import '../../../services/document_service.dart';
import '../../../services/vehicle_service.dart';
import '../../../ui/theme/colors.dart';
import '../document/add_car_document_screen.dart';
import '../document/document_car_details_screen.dart';

class VehicleProfileScreen extends StatefulWidget {
  final String carId;

  const VehicleProfileScreen({super.key, required this.carId});

  @override
  State<VehicleProfileScreen> createState() => _VehicleProfileScreenState();
}

class _VehicleProfileScreenState extends State<VehicleProfileScreen> {
  bool _loading = true;
  CarProfile? _profile;

  bool _loadingDocs = true;
  List<CarDocument> _docs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _load();
    });
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _loadingDocs = true;
    });
    try {
      final locale = AppLocalizations.of(context)!.localeName;

      final p = await VehicleService.getCarProfile(
        widget.carId,
        locale: locale,
      );
      final docs = await DocumentService.getCarDocuments(
        widget.carId,
        locale: locale,
      );

      if (!mounted) return;
      setState(() {
        _profile = p;
        _docs = docs.cast<CarDocument>();
      });
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(context, AppLocalizations.of(context)!.unexpectedError);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadingDocs = false;
        });
      }
    }
  }

  Widget _sectionHeader(String text) => Padding(
    padding: const EdgeInsetsDirectional.only(
      top: 12,
      start: 12,
      end: 12,
      bottom: 8,
    ),
    child: Text(
      text,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    ),
  );

  Widget _kv(String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _kvGroup(List<MapEntry<String, String?>> entries) => entries
      .where((e) => (e.value ?? '').trim().isNotEmpty)
      .map((e) => _kv(e.key, e.value))
      .toList();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : (_profile == null)
            ? Center(child: Text(t.unexpectedError))
            : RefreshIndicator(
          onRefresh: _load,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.textPrimary,
                      ),
                      splashRadius: 22,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Text(
                    t.vehicleProfile,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: .2,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      _profile!.displayName(lang).isEmpty
                          ? t.myVehicles
                          : _profile!.displayName(lang),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                GroupCard(
                  children: [
                    _sectionHeader(t.carDetails),
                    ..._kvGroup([
                      MapEntry(t.etronNumber, _profile!.userCarId),
                      MapEntry(t.plateCountry, _profile!.plateCountry),
                      MapEntry(
                        t.manufacturingCountry,
                        _profile!.manufacturingCountry,
                      ),
                      MapEntry(t.plateNumber, _profile!.plateNumber),
                    ]),
                  ],
                ),

                const SizedBox(height: 16),

                GroupCard(
                  children: [
                    _sectionHeader(t.chargerType),
                    ..._kvGroup([
                      MapEntry(t.acChargerType, _profile!.acCharger),
                      MapEntry(t.dcChargerType, _profile!.dcCharger),
                    ]),
                  ],
                ),

                const SizedBox(height: 16),

                GroupCard(
                  children: [
                    _sectionHeader(t.documents),
                    if (_loadingDocs) ...[
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ] else ...[
                      if (_docs.isEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                          child: Text(
                            t.noDocumentsYet,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ] else ...[
                        ..._buildDocumentsList(context, t),
                      ],
                    ],
                  ],
                ),

                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: AddVehicleDashedButton(
                    label: t.addDocument,
                    onPressed: () async {
                      final added = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddCarDocumentScreen(carId: widget.carId),
                        ),
                      );
                      if (added == true && mounted) {
                        AppSnackbar.success(context, t.savedSuccessfully);
                        await _load();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDocumentsList(BuildContext context, AppLocalizations t) {
    final Map<String, List<CarDocument>> grouped = {};
    for (final d in _docs) {
      grouped.putIfAbsent(d.groupId, () => []).add(d);
    }

    final tiles = <Widget>[];
    grouped.forEach((groupId, list) {
      list.sort((a, b) => b.actualVersion.compareTo(a.actualVersion));
      final latest = list.first;

      tiles.add(
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          title: Text(
            latest.name,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            '${t.expiryDate}: ${latest.endDate ?? '-'} • ${t.version}: ${latest.versionLabel}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            final changed = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DocumentDetailsScreen(
                  carId: widget.carId,
                  groupId: groupId,
                  documentTypeName: latest.name,
                  versionsOfGroup: list,
                ),
              ),
            );
            if (changed == true) await _load();
          },
        ),
      );
      tiles.add(const Divider(height: 1, color: AppColors.divider));
    });
    if (tiles.isNotEmpty) tiles.removeLast();
    return tiles;
  }
}