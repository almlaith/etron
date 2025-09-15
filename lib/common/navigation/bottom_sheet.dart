import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';

class EtronBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final String? icon; // SVG path
  final Color? iconColor;
  final double iconSize;

  const EtronBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
    this.titleStyle,
    this.icon,
    this.iconColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (icon != null) {
      leading = PrimaryIcon(icon: icon!, iconSize: iconSize, iconColor: iconColor);
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (leading != null) ...[
                leading,
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: titleStyle ??
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}