import 'package:flutter/material.dart';
import 'package:etron_flutter/common/button/primary_icon.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class AddVehicleCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddVehicleCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0, top: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                Color.lerp(AppColors.primary, AppColors.secondary, 0.4)!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const PrimaryIcon(
                icon: 'assets/icons/car.svg',
                iconSize: 28,
                iconColor: AppColors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.addYourVehicleNow,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.addVehicleToAccessFeatures,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}