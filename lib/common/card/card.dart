  import 'package:flutter/material.dart';
  import '../../ui/theme/colors.dart';
  import '../button/primary_icon.dart';

  class EtronCard extends StatelessWidget {
    final Widget child;
    final EdgeInsets padding;
    final String? icon;
    final double iconSize;
    final Color? iconColor;
    final Widget? trailing;
    final Color? backgroundColor;
    final Color? borderColor;
    final Color? shadowColor;

    const EtronCard({
      super.key,
      required this.child,
      this.padding = const EdgeInsets.all(16),
      this.icon,
      this.iconSize = 28,
      this.iconColor,
      this.trailing,
      this.backgroundColor,
      this.borderColor,
      this.shadowColor,
    });

    @override
    Widget build(BuildContext context) {
      final Color effectiveBackground = backgroundColor ?? AppColors.surface;
      final Color effectiveBorder = borderColor ?? AppColors.white;
      final Color effectiveShadow = shadowColor ?? AppColors.primary.withOpacity(0.1);
      return Card(
        elevation: 1,
        shadowColor: effectiveShadow,
        color: effectiveBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: effectiveBorder, width: 1.5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                PrimaryIcon(icon: icon!, iconSize: iconSize, iconColor: iconColor),
                const SizedBox(width: 16),
              ],
              Expanded(child: child),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      );
    }
  }
