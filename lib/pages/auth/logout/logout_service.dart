import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
import '../../../l10n/app_localizations.dart';

Future<void> performLogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');
  final tr = AppLocalizations.of(context)!;
  // print('Sending token: Bearer $token');

  try {
    final response = await http.post(
      Uri.parse('https://stgapi.etron-mena.com/user/logout'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    bool ok = false;

    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body);
        ok = (json is Map) &&
            (json['isValid'] == true);
      } catch (_) {}
    } else if (response.statusCode == 401) {
      ok = true;
    }

    if (ok) {
      await prefs.remove('accessToken');
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
      );
    } else {
      _showMessage(context, tr.logoutFailed);
    }
  } catch (_) {
    _showMessage(context, tr.unexpectedError);
  }
}

void _showMessage(BuildContext ctx, String msg) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
}
