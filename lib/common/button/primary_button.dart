import 'package:etron_flutter/common/button/primary_icon.dart';
import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final Color? color;
  final String? icon;
  final double iconSize;
  final Color? iconColor;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = true,
    this.isLoading = false,
    this.color,
    this.icon,
    this.iconSize = 20,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? AppColors.primary;
    return Container(
      width: isFullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: effectiveColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: effectiveColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          PrimaryIcon(
                            icon: icon!,
                            iconSize: iconSize,
                            iconColor: iconColor ?? AppColors.white,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
