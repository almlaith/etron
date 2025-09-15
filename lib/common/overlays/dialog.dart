import 'package:flutter/material.dart';
import 'package:etron_flutter/l10n/app_localizations.dart'; // تأكد من المسار الصحيح

/// Dialog عام يُستخدم لعرض تنبيهات مع زر تأكيد
void showAppDialog( {
  required BuildContext context,
  required String title,
  required String message,
  required String confirmButtonText,
  required VoidCallback onConfirm,
  IconData? leadingIcon,
}) {
  final tr = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // إغلاق
          child: Text(
            tr.cancel,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: Text(
            confirmButtonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
