import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

String mapApiMessage(BuildContext context, String? apiMessage) {
  final tr = AppLocalizations.of(context)!;

  if (apiMessage == null) return tr.unknownError;

   if (apiMessage.startsWith('tooManyAttempts')) {
    final parts = apiMessage.split(':');
    final minutes = int.tryParse(parts.elementAtOrNull(1) ?? '') ?? 1;
    return tr.tooManyAttempts(minutes);
  }

  switch (apiMessage) {
    case 'InvalidCredentials':
    case 'invalidCredentials':
    case 'loginInvalidCredentials':
      return tr.invalidCredentials;

    case 'phoneNotRegistered':
    case 'PhoneNotRegistered':
      return tr.phoneNotRegistered;

    case 'accountLocked':
    case 'AccountLocked':
      return tr.accountLocked;

    case 'passwordExpired':
    case 'PasswordExpired':
      return tr.passwordExpired;

    case 'serverUnavailable':
    case 'ServerUnavailable':
      return tr.serverUnavailable;

    case 'loginUnexpectedError':
    case 'LoginUnexpectedError':
      return tr.loginUnexpectedError;

    case 'PhoneAlreadyExists':
      return tr.phoneAlreadyExists;

    case 'OtpInvalidOrExpired':
      return tr.otpExpiredOrInvalid;


    case 'EmailAlreadyExists':
    case 'emailAlreadyExists':
      return tr.emailAlreadyExists;


    default:
      return tr.unknownError;
  }
}


