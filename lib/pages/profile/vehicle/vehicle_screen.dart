import 'package:etron_flutter/models/vehicle_model.dart';
import 'package:etron_flutter/services/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import '../../../common/button/add_vehicle_button.dart';
import '../../../common/card/vehicle_card.dart';
import 'vehicle_profile_screen.dart';
import 'add_vehicle_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});
  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  bool _loading = true;
  List<UserVehicle> _cars = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final locale = Localizations.localeOf(context).languageCode;
      final items = await VehicleService.getUserCars(locale: locale);
      if (!mounted) return;
      setState(() => _cars = items);
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(context, AppLocalizations.of(context)!.unexpectedError);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final langCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
                    splashRadius: 22,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    t.myVehicles,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AddVehicleDashedButton(
                label: t.addVehicleCta,
                onPressed: () async {
                  final ok = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
                  );
                  if (ok == true) _load();
                },
              ),
              const SizedBox(height: 16),
              if (_cars.isEmpty) ...[
                Center(
                  child: Text(
                    t.vehiclesEmptyHelper,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.5),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cars.length,
                  itemBuilder: (context, index) {
                    final c = _cars[index];
                    return InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => VehicleProfileScreen(carId: c.carId)),
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          final List<MapEntry<String, String?>> vehicleDetails = [
                            MapEntry(t.etronNumber, c.userCarId),
                            MapEntry(t.acChargerType, c.acCharger),
                            MapEntry(t.dcChargerType, c.dcCharger),
                            MapEntry(t.plateNumber, c.plateNumber),
                            MapEntry(t.carColorHint, c.carColor),
                          ];

                          return VehicleCard(
                            title: c.displayName(langCode).isEmpty ? t.myVehicles : c.displayName(langCode),
                            details: vehicleDetails,
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}