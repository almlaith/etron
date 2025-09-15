import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';

import 'language_toggle_button.dart';

class LanguageSwitchBar extends StatelessWidget {
  const LanguageSwitchBar({
    super.key,
    this.onChanged,
    this.margin,
  });

   final VoidCallback? onChanged;

   final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final t = AppLocalizations.of(context)!;

     final label = isArabic
        ? t.switchLanguageToEnglish
        : t.switchLanguageToArabic;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
           LanguageToggleButton(
            onLanguageChanged: () {
               onChanged?.call();
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7E7A7A),
                letterSpacing: .2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
