import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/common/card/group_card.dart';
import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/services/auth_service.dart';
import 'package:etron_flutter/common/validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentCtrl = TextEditingController();
  final _newCtrl     = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _saving    = false;
  bool _submitted = false;
  bool _obCur = true, _obNew = true, _obCon = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String _mapApiMessage(BuildContext context, String? code) {
    final t = AppLocalizations.of(context)!;
    switch ((code ?? '').trim()) {
      case 'PasswordsDoNotMatch':
      case 'passwordsDoNotMatch':
        return t.passwordsDoNotMatch;
      case 'CurrentPasswordIncorrect':
      case 'currentPasswordIncorrect':
        return t.invalidPassword;
      case 'UserNotFound':
      case 'userNotFound':
        return t.phoneNumberNotRegistered;
      default:
        return t.unexpectedError;
    }
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    final t = AppLocalizations.of(context)!;

    if (_newCtrl.text.trim() != _confirmCtrl.text.trim()) {
      AppSnackbar.error(context, t.passwordsDoNotMatch);
      return;
    }

    setState(() => _saving = true);
    try {
      final res = await AuthService.changePassword(
        currentPassword: _currentCtrl.text.trim(),
        newPassword: _newCtrl.text.trim(),
        confirmPassword: _confirmCtrl.text.trim(),
      );

      if (res.success) {
        AppSnackbar.success(context, t.passwordResetSuccess);
        if (mounted) Navigator.of(context).maybePop();
      } else {
        AppSnackbar.error(context, _mapApiMessage(context, res.message));
      }
    } catch (_) {
      AppSnackbar.error(context, AppLocalizations.of(context)!.unexpectedError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 8, start: 12, end: 12),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
                    splashRadius: 22,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _saving ? null : _save,
                    child: Text(
                      t.save,
                      style: TextStyle(
                        color: _saving ? AppColors.textSecondary : AppColors.primary,
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
                  t.changePasswordTitle,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              GroupCard(
                children: [
                  _sectionLabel(t.currentPassword),
                  const Divider(height: 1, color: AppColors.divider),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),

                    child: Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: const InputDecorationTheme(
                          errorMaxLines: 4,
                          helperMaxLines: 4,
                          errorStyle: TextStyle(fontSize: 12, height: 1.2),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        autovalidateMode:
                        _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            InputField(
                              label: '',
                              controller: _currentCtrl,
                              hintText: t.enterCurrentPasswordHint,
                              obscureText: _obCur,
                              borderColor: Colors.transparent,
                              fillColor: AppColors.white,
                              autovalidateMode:
                              _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obCur = !_obCur),
                                icon: Icon(
                                  _obCur ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              validator: (v) => Validator.validate(
                                context,
                                v,
                                [Validator.required()],
                              ),
                            ),

                            _sectionLabel(t.newPassword),
                            const Divider(height: 1, color: AppColors.divider),
                            InputField(
                              label: '',
                              controller: _newCtrl,
                              hintText: t.enterNewPasswordHint,
                              obscureText: _obNew,
                              borderColor: Colors.transparent,
                              fillColor: AppColors.white,
                              autovalidateMode:
                              _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obNew = !_obNew),
                                icon: Icon(
                                  _obNew ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              validator: (v) => Validator.validate(
                                context,
                                v,
                                [
                                  Validator.required(),
                                  Validator.passwordLength(),
                                  Validator.passwordComplex(),
                                ],
                              ),
                            ),

                            _sectionLabel(t.confirmNewPassword),
                            const Divider(height: 1, color: AppColors.divider),
                            InputField(
                              label: '',
                              controller: _confirmCtrl,
                              hintText: t.confirmNewPasswordHint,
                              obscureText: _obCon,
                              borderColor: Colors.transparent,
                              fillColor: AppColors.white,
                              autovalidateMode:
                              _submitted ? AutovalidateMode.always : AutovalidateMode.disabled,
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obCon = !_obCon),
                                icon: Icon(
                                  _obCon ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              validator: (v) {
                                final base = Validator.validate(
                                  context,
                                  v,
                                  [Validator.required()],
                                );
                                if (base != null) return base;
                                if ((v ?? '').trim() != _newCtrl.text.trim()) {
                                  return t.passwordsDoNotMatch;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}