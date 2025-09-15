import 'package:flutter/material.dart';

import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';


class AppSnackbar {
  static void show(
      BuildContext context,
      String message, {
        bool isError = false,
        String? icon,
        IconData? leadingIcon,
        double iconSize = 20,
        Color? iconColor,
        Color? leadingIconColor,
        int durationSeconds = 3,
      }) {
    final messenger = ScaffoldMessenger.of(context);

    Widget? leading;
    if (icon != null) {
      leading = PrimaryIcon(
        icon: icon,
        iconSize: iconSize,
        iconColor: iconColor,
      );
    } else if (leadingIcon != null) {
      leading = Icon(
        leadingIcon,
        size: iconSize,
        color: leadingIconColor ?? Colors.white,
      );
    }

    final snackBar = SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isError ? AppColors.error : AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: Duration(seconds: durationSeconds),
    );

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(snackBar);
  }

  static void success(BuildContext context, String message) {
    show(context, message, isError: false, leadingIcon: Icons.check_circle);
  }

  static void error(BuildContext context, String message) {
    show(context, message, isError: true, leadingIcon: Icons.error);
  }
}
