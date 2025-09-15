import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class VehicleCard extends StatelessWidget {
  final String title;

  final List<MapEntry<String, String?>> details;

  const VehicleCard({
    super.key,
    required this.title,
     required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

     final validDetails = details.where((d) => d.value != null && d.value!.trim().isNotEmpty).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
           if (validDetails.isNotEmpty) ...[
            const SizedBox(height: 12),
            Divider(height: 1, color: AppColors.primary.withOpacity(.25)),
            const SizedBox(height: 12),
             for (final entry in validDetails) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      entry.key,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                     Expanded(
                      child: Text(
                        entry.value!,
                        textAlign: isRtl ? TextAlign.left : TextAlign.end,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ]
         ],
      ),
    );
  }
}