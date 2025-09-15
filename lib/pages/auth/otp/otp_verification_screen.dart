import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/auth_service.dart';
import '../../../services/gateway_service.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/field/input_field.dart';
import '../../../common/overlays/snackbar.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/api_message_mapper.dart';
import '../../../ui/theme/colors.dart';
import '../login/login_screen.dart';
import '../password/forgot_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;
  final String otpKey;
  final bool forResetPassword;
  final String? name;
  final String? password;
  final String? email;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
    required this.otpKey,
    this.forResetPassword = false,
    this.name,
    this.password,
    this.email,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();

  static const int _initialSeconds = 300;
  int _secondsLeft = _initialSeconds;
  Timer? _timer;

  bool _loading = false;
  late String _currentKey;

  @override
  void initState() {
    super.initState();
    _currentKey = widget.otpKey;
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _initialSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _resendOtp() async {
    if (!mounted) return;
    final tr = AppLocalizations.of(context)!;

    setState(() => _loading = true);
    final res = await GatewayService.sendOtp(phone: widget.phone);
    setState(() => _loading = false);

    final newKey = res.data?['key']?.toString();
    if (newKey != null && newKey.isNotEmpty) {
      _currentKey = newKey;
      _otpController.clear();
      AppSnackbar.success(context, tr.otpResentMessage);
      _startCountdown();
    } else {
      final msg = mapApiMessage(context, res.message);
      AppSnackbar.error(context, msg ?? tr.unknownError);
    }
  }

  Future<void> _verifyOtp() async {
    final tr = AppLocalizations.of(context)!;
    final code = _otpController.text.trim();

    if (code.length != 4) {
      AppSnackbar.error(context, tr.invalidCode);
      return;
    }

    setState(() => _loading = true);
    final resVerify = await GatewayService.verifyOtp(
      key: _currentKey,
      otp: code,
    );
    setState(() => _loading = false);

    if (resVerify.success) {
      if (widget.forResetPassword) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ForgotPasswordScreen(phone: widget.phone),
          ),
        );
      } else {
        // تمرير otpKey + otpCode مع طلب التسجيل
        final resSignup = await AuthService.signup(
          phone: widget.phone,
          name: widget.name!,
          password: widget.password!,
          confirmPassword: widget.password!,
          email: widget.email,
          otpKey: _currentKey,
          otpCode: code,
        );

        if (resSignup.success) {
          if (!mounted) return;
          AppSnackbar.success(context, tr.signupSuccess);
          await Future.delayed(const Duration(milliseconds: 400));
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
          );
        } else {
          if (!mounted) return;
          final data = resSignup.data ?? const <String, dynamic>{};
          String? pretty;
          if (data['errors'] is Map && (data['errors'] as Map).isNotEmpty) {
            final first = (data['errors'] as Map).values.first;
            if (first is List && first.isNotEmpty) {
              pretty = first.first.toString();
            } else {
              pretty = first.toString();
            }
          }
          final msg =
              mapApiMessage(context, resSignup.message) ?? pretty ?? tr.unexpectedError;
          AppSnackbar.error(context, msg);
        }
      }
      return;
    }

    if (_secondsLeft == 0) {
      AppSnackbar.error(context, tr.otpExpiredOrInvalid);
    } else {
      AppSnackbar.error(context, tr.invalidCode);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    final timeLeft = '$minutes:$seconds';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/otp_screen.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    tr.otpVerificationTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr.otpSentTo(widget.phone.replaceRange(3, 9, "******")),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  InputField(
                    label: tr.verificationCode,
                    controller: _otpController,
                    hintText: tr.enterVerificationCode,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (v.length == 4) _verifyOtp();
                    },
                  ),
                  const SizedBox(height: 12),
                  (_secondsLeft == 0)
                      ? TextButton(
                    onPressed: _resendOtp,
                    child: Text(
                      tr.resendCode,
                      style: const TextStyle(color: Colors.green),
                    ),
                  )
                      : Text(
                    tr.codeExpiresIn(timeLeft),
                    style: const TextStyle(color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: tr.verify,
                    isLoading: _loading,
                    onPressed: _verifyOtp,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
