import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String? icon;           // SVG
  final double iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;

  const EmptyState({
    super.key,
    required this.message,
    this.leadingIcon = Icons.inbox_outlined,
    this.leadingIconColor,
    this.icon,
    this.iconSize = 64,
    this.iconColor,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    Widget displayedIcon = Icon(
      leadingIcon,
      size: iconSize,
      color: leadingIconColor ?? AppColors.textSecondary.withOpacity(0.5),
    );
    if (icon != null) {
      displayedIcon = PrimaryIcon(
        icon: icon!,
        iconSize: iconSize,
        iconColor: iconColor ?? AppColors.textSecondary.withOpacity(0.5),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayedIcon,
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: messageStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}