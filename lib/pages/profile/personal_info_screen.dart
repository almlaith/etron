import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/button/outlined_soft_button.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/common/field/phone_input_country_selector.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/models/country_model.dart';
import 'package:etron_flutter/services/gateway_service.dart';
import 'package:etron_flutter/services/user_service.dart';

import '../../common/button/confirmation_bottom_sheet.dart';
import '../../services/auth_service.dart';
import '../Intro/welcome_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool _loading = true;
  bool _saving = false;
  bool _isDeleting = false;

  bool _editPhone = false;
  String _name = '';
  String _email = '';
  String _nationalId = '';
  String _phone = '';

  // Controllers and models for input fields
  final _newPhoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  CountryModel? _country;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _loading = true);
    final data = await UserService.getMyProfile();
    if (!mounted) return;
    setState(() {
      _name = (data?['name'] ?? '').toString();
      _email = (data?['userEmail'] ?? data?['email'] ?? '').toString();
      _nationalId = (data?['nationalId'] ?? data?['nationalID'] ?? '')
          .toString();
      _phone = (data?['phoneNumber'] ?? data?['phone'] ?? '').toString();
      _loading = false;
    });
  }

  Future<void> _save() async {
    if (!_editPhone) return;
    final t = AppLocalizations.of(context)!;
    if (_country == null) {
      AppSnackbar.error(context, t.country);
      return;
    }
    if (_newPhoneCtrl.text.trim().isEmpty) {
      AppSnackbar.error(context, t.invalidPhoneNumber);
      return;
    }
    if (_passwordCtrl.text.isEmpty) {
      AppSnackbar.error(context, t.password);
      return;
    }
    setState(() => _saving = true);
    try {
      final formatted = await GatewayService.formatPhone(
        _country!.countryCode,
        _newPhoneCtrl.text.trim(),
      );
      if (formatted == null) {
        if (mounted) AppSnackbar.error(context, t.invalidPhoneNumber);
        return;
      }
      final res = await UserService.updatePhoneNumber(
        newPhone: formatted,
        password: _passwordCtrl.text,
      );
      if (!mounted) return;
      if (res.success) {
        AppSnackbar.success(context, t.snackbarSuccess);
        setState(() {
          _phone = formatted;
          _editPhone = false;
          _newPhoneCtrl.clear();
          _passwordCtrl.clear();
        });
      } else {
        final msg = (res.message ?? t.unknownError).toString();
        AppSnackbar.error(context, msg.isEmpty ? t.unknownError : msg);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _handleDeleteAccount() async {
    final t = AppLocalizations.of(context)!;

    await ConfirmationBottomSheet.show(
      context: context,
      title: t.deleteMyAccount,
      message: t.deleteAccountConfirmationMessage,
      confirmButtonText: t.delete,
      onConfirm: () async {
        if (!mounted) return;
        setState(() => _isDeleting = true);

        try {
          final res = await UserService.deleteAccount();
          if (!mounted) return;

          if (res.success) {
            AppSnackbar.success(context, t.accountDeletedSuccessfully);

            await AuthService.logout();
            if (!mounted) return;

            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              (route) => false,
            );
          } else {
            final msg = (res.message ?? t.unknownError).toString();
            AppSnackbar.error(context, msg.isEmpty ? t.unknownError : msg);
          }
        } finally {
          if (mounted) setState(() => _isDeleting = false);
        }
      },
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _labelGrey(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 6, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _valueBlack(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 12, bottom: 14),
      child: Text(
        text.isEmpty ? '—' : text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... (الكود هنا لم يتغير)
    final t = AppLocalizations.of(context)!;
    final isActionInProgress = _loading || _saving || _isDeleting;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Stack(
        children: [
          SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: isActionInProgress
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: isActionInProgress
                                  ? null
                                  : () => Navigator.of(context).maybePop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.textPrimary,
                              ),
                              splashRadius: 22,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: _saving ? null : _save,
                              child: Text(
                                t.save,
                                style: TextStyle(
                                  color: _saving
                                      ? AppColors.textSecondary
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 16),
                          child: Text(
                            t.yourAccount,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _sectionTitle(t.accountInformation),
                        GroupCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _labelGrey(t.phoneNumber),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.divider,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: _valueBlack(_phone)),
                                      GestureDetector(
                                        onTap: isActionInProgress
                                            ? null
                                            : () => setState(
                                                () => _editPhone = !_editPhone,
                                              ),
                                        child: Text(
                                          t.changeQuestion,
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_editPhone) ...[
                                    const SizedBox(height: 12),
                                    PhoneInputWithCountrySelector(
                                      selectedCountry: _country,
                                      onCountryChanged: (c) =>
                                          setState(() => _country = c),
                                      controller: _newPhoneCtrl,
                                      label: '',
                                      hintText: t.phoneHint,
                                      borderColor: AppColors.primary,
                                      fillColor: Colors.white,
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                    ),
                                    const SizedBox(height: 12),
                                    InputField(
                                      label: '',
                                      controller: _passwordCtrl,
                                      hintText: t.currentPassword,
                                      obscureText: true,
                                      borderColor: AppColors.primary,
                                      fillColor: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _sectionTitle(t.personalInformation),
                        GroupCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _labelGrey(t.fullName),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.divider,
                                  ),
                                  _valueBlack(_name),
                                  _labelGrey(t.email),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.divider,
                                  ),
                                  _valueBlack(_email),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 235),
                        OutlinedSoftButton(
                          text: t.deleteMyAccount,
                          onPressed: isActionInProgress
                              ? null
                              : _handleDeleteAccount,
                        ),
                      ],
                    ),
                  ),
          ),
          if (_isDeleting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
