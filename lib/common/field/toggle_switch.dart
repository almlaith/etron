import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';

class AppToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppToggleSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
      activeTrackColor: AppColors.textSecondary.withOpacity(0.5),
    );
  }
}