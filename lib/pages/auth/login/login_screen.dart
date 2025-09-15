import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:etron_flutter/ui/theme/colors.dart';
import 'package:etron_flutter/l10n/app_localizations.dart';
import 'package:etron_flutter/services/auth_service.dart';
import 'package:etron_flutter/services/gateway_service.dart';
import 'package:etron_flutter/common/button/primary_button.dart';
import 'package:etron_flutter/common/field/input_field.dart';
import 'package:etron_flutter/common/field/phone_input_country_selector.dart';
 import 'package:etron_flutter/common/overlays/snackbar.dart';
import 'package:etron_flutter/common/validator.dart';
import 'package:etron_flutter/models/country_model.dart';
import 'package:etron_flutter/services/api_message_mapper.dart';
import 'package:etron_flutter/services/storage_service.dart';
import '../../../common/button/language/language_toggle_button.dart';
import '../../home/home_screen.dart';
import '../otp/send_otp_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _loading = false;
  bool _obscure = true;
  bool _submitted = false;
  CountryModel? _country;

  String? _extractUserLoginId(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      final direct = data['userLoginId'] ??
          data['user_login_id'] ??
          data['user_loginId'] ??
          data['userId'] ??
          data['id'];
      if (direct != null && direct.toString().isNotEmpty) {
        return direct.toString();
      }
      for (final parent in ['user', 'profile', 'account', 'data']) {
        final nested = data[parent];
        if (nested is Map) {
          final nestedId = nested['userLoginId'] ??
              nested['user_login_id'] ??
              nested['user_loginId'] ??
              nested['userId'] ??
              nested['id'];
          if (nestedId != null && nestedId.toString().isNotEmpty) {
            return nestedId.toString();
          }
        }
      }
    }
    return null;
  }

  Future<void> _login() async {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    if (_country == null) {
      AppSnackbar.error(context, l10n.country);
      return;
    }

    setState(() => _loading = true);

    try {
       final formatted = await GatewayService.formatPhone(
        _country!.countryCode,
        _phoneCtrl.text.trim().replaceAll(' ', ''),
      );

      if (formatted == null) {
        if (!mounted) return;
        AppSnackbar.error(context, l10n.invalidPhoneNumber);
        setState(() => _loading = false);
        return;
      }

       final verifyRes = await AuthService.authVerifySignup(formatted);
      bool userExists = false;
      if (verifyRes.success) {
        final data = verifyRes.data?['data'];
        if (data is Map<String, dynamic>) {
          userExists = (data['exists'] ?? data['phoneExists'] ?? false) as bool;
        }
      } else {
         if (!mounted) return;
        final msg = mapApiMessage(context, verifyRes.message);
        AppSnackbar.error(context, msg);
        setState(() => _loading = false);
        return;
      }

      if (!userExists) {
        if (!mounted) return;
         AppSnackbar.error(context, l10n.invalidCredentials);
        setState(() => _loading = false);
        return;
      }

       final res = await AuthService.login(
        phone: formatted,
        password: _passCtrl.text.trim(),
      );

      if (res.success) {
        final Map<String, dynamic> data = (res.data?['data'] is Map)
            ? Map<String, dynamic>.from(res.data!['data'])
            : {};

        final accessToken = data['accessToken']?.toString();
        if (accessToken != null && accessToken.isNotEmpty) {
          await StorageService.saveAccessToken(accessToken);
        }

        final userLoginId = _extractUserLoginId(data);
        if (userLoginId != null && userLoginId.isNotEmpty) {
          await StorageService.saveUserLoginId(userLoginId);
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setBool('isPhoneVerified', true);

        if (!mounted) return;
        AppSnackbar.success(context, l10n.loginSuccess);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        if (!mounted) return;
        final msg = mapApiMessage(context, res.message);
        AppSnackbar.error(context, msg);
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.error(context, l10n.loginUnexpectedError);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  void _goToForgot() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SendOtpScreen(forResetPassword: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/frame_mob.svg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: LanguageToggleButton(
                        onLanguageChanged: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) setState(() {});
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 100),
                    Image.asset('assets/logo/logo-name.png', height: 80),
                    const SizedBox(height: 12),
                    Text(
                      t.loginHere,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.welcomeBackBig,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              PhoneInputWithCountrySelector(
                                key: ValueKey('phone-${t.localeName}'),
                                selectedCountry: _country,
                                onCountryChanged: (c) => setState(() => _country = c),
                                controller: _phoneCtrl,
                                autovalidateMode: _submitted
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (v) => Validator.validate(
                                  context,
                                  v,
                                  [Validator.required()],
                                ),
                                label: '',
                                hintText: t.phoneHint,
                                borderColor: AppColors.primary,
                                fillColor: Colors.transparent,
                              ),
                              const SizedBox(height: 24),
                              InputField(
                                key: ValueKey('pass-${t.localeName}'),
                                label: '',
                                controller: _passCtrl,
                                hintText: t.password,
                                obscureText: _obscure,
                                autovalidateMode: _submitted
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                borderColor: AppColors.primary,
                                fillColor: AppColors.surface.withOpacity(0.6),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => _obscure = !_obscure),
                                  icon: Icon(
                                    _obscure ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                ),
                                validator: (v) => Validator.validate(context, v, [
                                  Validator.required(),
                                  Validator.passwordLength(),
                                  Validator.passwordComplex(),
                                ]),
                              ),
                              const SizedBox(height: 6),
                              Align(
                                alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: _goToForgot,
                                  child: Text(
                                    t.forgotPassword,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              PrimaryButton(
                                text: t.signIn,
                                isLoading: _loading,
                                onPressed: _loading ? null : _login,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    t.createNewAccount,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: _goToSignUp,
                                    child: Text(
                                      t.signUp,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
