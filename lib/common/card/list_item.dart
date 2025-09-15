import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String? icon;            // SVG
  final double iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Color? trailingIconColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.leadingIconColor,
    this.icon,
    this.iconSize = 24,
    this.iconColor,
    this.onTap,
    this.trailingIconColor,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitleStyle = titleStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        );
    final effectiveSubtitleStyle = subtitleStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary);

    Widget? leadingWidget;
    if (icon != null) {
      leadingWidget = PrimaryIcon(icon: icon!, iconSize: iconSize, iconColor: iconColor);
    } else if (leadingIcon != null) {
      leadingWidget = Icon(leadingIcon, color: leadingIconColor ?? Theme.of(context).colorScheme.primary);
    }

    return ListTile(
      leading: leadingWidget,
      title: Text(title, style: effectiveTitleStyle),
      subtitle: subtitle != null ? Text(subtitle!, style: effectiveSubtitleStyle) : null,
      trailing: Icon(Icons.chevron_right, color: trailingIconColor ?? AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

