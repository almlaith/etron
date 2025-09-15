import 'package:flutter/material.dart';
 import '../../../ui/theme/colors.dart';
import 'language_wrapper.dart';

  class LanguageToggleButton extends StatelessWidget {
  final VoidCallback? onLanguageChanged;

  const LanguageToggleButton({super.key, this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final label = isArabic ? 'ع' : 'En';

    void _switch() {
      LanguageWrapper.of(context)?.onToggleLanguage();
       WidgetsBinding.instance.addPostFrameCallback((_) {
        onLanguageChanged?.call();
      });
    }

    return InkWell(
      onTap: _switch,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 48,
        height: 48,
         alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isArabic ? AppColors.primary : AppColors.white,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isArabic ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
