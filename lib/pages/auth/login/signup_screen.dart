import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/auth_service.dart';
import '../../../services/gateway_service.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/field/input_field.dart';
import '../../../common/field/phone_input_country_selector.dart';
import '../../../common/overlays/snackbar.dart';
import '../../../common/validator.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/country_model.dart';
import '../../../ui/theme/colors.dart';
import '../login/login_screen.dart';
import '../otp/otp_verification_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _submitted = false;
  bool _loading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  CountryModel? _country;

  Future<void> _signup() async {
    final t = AppLocalizations.of(context)!;
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    // ✅ الهاتف إجباري
    if (_country == null || _phoneCtrl.text.trim().isEmpty) {
      AppSnackbar.error(context, t.phoneNumber);
      return;
    }

    setState(() => _loading = true);

    // تهيئة الهاتف بصيغة دولية
    final formattedPhone = await GatewayService.formatPhone(
      _country!.countryCode,
      _phoneCtrl.text.trim().replaceAll(' ', ''),
    );
    if (formattedPhone == null) {
      AppSnackbar.error(context, t.invalidPhoneNumber);
      setState(() => _loading = false);
      return;
    }

    // ✅ تحقّق مسبق من الهاتف + الإيميل قبل إرسال OTP
    final email = _emailCtrl.text.trim();
    final verifyRes = await AuthService.authVerifySignup(
      formattedPhone,
      email: email.isEmpty ? null : email,
    );

    if (verifyRes.success != true) {
      AppSnackbar.error(context, verifyRes.message ?? t.unexpectedError);
      setState(() => _loading = false);
      return;
    }

    final data = verifyRes.data?['data'] as Map<String, dynamic>?;

    final phoneExists = (data?['phoneExists'] ?? false) as bool;
    final emailExists = (data?['emailExists'] ?? false) as bool;

    if (phoneExists) {
      AppSnackbar.error(context, t.phoneAlreadyExists);
      setState(() => _loading = false);
      return;
    }

    if (emailExists) {
      AppSnackbar.error(context, t.emailAlreadyExists);
      setState(() => _loading = false);
      return;
    }

    // لا يوجد تعارض → أرسل OTP
    final otpRes = await GatewayService.sendOtp(phone: formattedPhone);
    if (otpRes.success && otpRes.data?.containsKey('key') == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phone: formattedPhone,
            otpKey: otpRes.data!['key'],
            forResetPassword: false,
            name: _nameCtrl.text.trim(),
            password: _passCtrl.text.trim(),
            email: email.isEmpty ? null : email,
          ),
        ),
      );
    } else {
      AppSnackbar.error(context, otpRes.message ?? t.unexpectedError);
    }

    if (mounted) setState(() => _loading = false);
  }

  void _goToLogin() => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final rtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/frame_mob.svg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        t.createAccount,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.signupSubtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        controller: _nameCtrl,
                        hintText: t.fullName,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (v) => Validator.validate(context, v, [
                          Validator.required(),
                        ]),
                        borderColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        label: '',
                      ),
                      const SizedBox(height: 24),
                      PhoneInputWithCountrySelector(
                        selectedCountry: _country,
                        onCountryChanged: (c) => setState(() => _country = c),
                        controller: _phoneCtrl,
                        hintText: t.phoneNumber,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (v) => Validator.validate(context, v, [
                          Validator.required(),
                        ]),
                        borderColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        label: '',
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        hintText: t.email,
                        controller: _emailCtrl,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (v) => Validator.validate(context, v, [
                          if (v != null && v.trim().isNotEmpty) Validator.email(),
                        ]),
                        borderColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        label: '',
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        hintText: t.password,
                        controller: _passCtrl,
                        obscureText: _obscurePassword,
                        borderColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (v) => Validator.validate(context, v, [
                          Validator.required(),
                          Validator.passwordLength(),
                          Validator.passwordComplex(),
                        ]),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        label: '',
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        hintText: t.confirmPassword,
                        controller: _confirmPassCtrl,
                        obscureText: _obscureConfirm,
                        borderColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        autovalidateMode: _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        validator: (v) => Validator.validate(context, v, [
                          Validator.required(),
                          Validator.confirmPassword(_passCtrl.text),
                        ]),
                        suffixIcon: InkWell(
                          onTap: () =>
                              setState(() => _obscureConfirm = !_obscureConfirm),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        label: '',
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: t.signUp,
                        isLoading: _loading,
                        onPressed: _signup,
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: _goToLogin,
                        child: Text(
                          t.alreadyHaveAccount,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
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
