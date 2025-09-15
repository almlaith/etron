 import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class AppBackLink extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const AppBackLink({super.key, this.label = 'Back', this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.maybePop(context),
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.chevron_left, size: 22, color: AppColors.textPrimary),
          SizedBox(width: 6),
          Text(
            'Back',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
