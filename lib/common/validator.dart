  import 'package:flutter/material.dart';
  import 'package:collection/collection.dart';
  import '../../l10n/app_localizations.dart';

  typedef ValidationRule = String? Function(String? value, BuildContext context);

  class Validator {
     static String? validate(
        BuildContext context,
        String? value,
        List<ValidationRule> rules,
        ) =>
        rules.map((rule) => rule(value, context)).firstWhereOrNull((msg) => msg != null);

     static ValidationRule required() => (value, ctx) =>
    (value == null || value.trim().isEmpty)
        ? AppLocalizations.of(ctx)!.requiredField
        : null;

     static ValidationRule jordanPhone() => (value, ctx) {
      final regex = RegExp(r'^\+9627\d{8}$');
      return (value == null || !regex.hasMatch(value))
          ? AppLocalizations.of(ctx)!.invalidPhone
          : null;
    };

     static ValidationRule jordanLocalPhone() => (value, ctx) {
       final regex = RegExp(r'^7\d{8}$');
       return (value == null || !regex.hasMatch(value))
           ? AppLocalizations.of(ctx)!.invalidPhone
           : null;
     };


     static ValidationRule email() => (value, ctx) {
      final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
      return (value == null || !regex.hasMatch(value))
          ? AppLocalizations.of(ctx)!.invalidEmail
          : null;
    };

     static ValidationRule passwordLength() => (value, ctx) =>
    (value == null || value.length < 8)
        ? AppLocalizations.of(ctx)!.invalidPassword
        : null;

     static ValidationRule passwordComplex() => (value, ctx) {
       final hasLetter = RegExp(r'[a-zA-Z]');
       final isValid = value != null &&
           value.length >= 8 &&
           hasLetter.hasMatch(value);

       return isValid
           ? null
           : AppLocalizations.of(ctx)!.passwordComplexError;
     };

    static ValidationRule confirmPassword(String original) =>
            (value, ctx) =>
        (value == null || value != original)
            ? AppLocalizations.of(ctx)!.passwordMismatch
            : null;
  }
