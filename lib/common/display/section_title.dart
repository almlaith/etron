import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String? icon;           // SVG
  final Color? iconColor;
  final TextStyle? titleStyle;

  const SectionTitle({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingIconColor,
    this.icon,
    this.iconColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (icon != null) {
      leading = PrimaryIcon(icon: icon!, iconSize: 24, iconColor: iconColor ?? Theme.of(context).colorScheme.primary);
    } else if (leadingIcon != null) {
      leading = Icon(leadingIcon, color: leadingIconColor ?? Theme.of(context).colorScheme.primary);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        if (leading != null) ...[leading, const SizedBox(width: 8)],
        Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}