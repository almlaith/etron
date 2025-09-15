import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/field/input_field.dart';
import '../../../common/validator.dart';
import '../../../l10n/app_localizations.dart';
import '../../../ui/theme/colors.dart';
import '../login/login_screen.dart';
import '../../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String phone;

  const ForgotPasswordScreen({super.key, required this.phone});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    final password = _passwordController.text.trim();
    final confirmPw  = _confirmController.text.trim();

    setState(() => _loading = true);

    try {
      final res = await AuthService.forgotPassword(
          phone: widget.phone,
          password: password,
          confirmPassword: confirmPw
      );

      if (res.success) {
        _show(l10n.passwordResetSuccess);
        await Future.delayed(const Duration(milliseconds: 600));
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
          );
        }
      } else {
        _show(res.message ?? l10n.showError);
      }
    } catch (_) {
      _show(l10n.connectionErrorMessage);
    }

    if (mounted) setState(() => _loading = false);
  }

  void _show(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.resetPasswordTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/frame_mob.svg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      InputField(
                        label: "",
                        hintText: l10n.newPassword,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (v) => Validator.validate(context, v, [
                          Validator.required(),
                          Validator.passwordLength(),
                          Validator.passwordComplex(),
                        ]),
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: "",
                        hintText: l10n.confirmNewPassword,
                        controller: _confirmController,
                        obscureText: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) return l10n.requiredField;
                          if (v != _passwordController.text) {
                            return l10n.passwordsNotMatch;
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock_reset_outlined),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: l10n.confirm,
                        isLoading: _loading,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}