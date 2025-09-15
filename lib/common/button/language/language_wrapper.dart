import 'package:flutter/material.dart';

class LanguageWrapper extends InheritedWidget {
  final VoidCallback onToggleLanguage;

  const LanguageWrapper({
    super.key,
    required this.onToggleLanguage,
    required Widget child,
  }) : super(child: child);

  static LanguageWrapper? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LanguageWrapper>();
  }

  @override
  bool updateShouldNotify(covariant LanguageWrapper oldWidget) {
    return onToggleLanguage != oldWidget.onToggleLanguage;
  }
}
