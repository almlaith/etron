// lib/pages/auth/otp/send_otp_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/auth_service.dart';
import '../../../services/gateway_service.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/overlays/snackbar.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/country_model.dart';
import '../../../common/field/phone_input_country_selector.dart';
import '../../../services/api_message_mapper.dart';
import '../../../ui/theme/colors.dart';
import '../otp/otp_verification_screen.dart';

class SendOtpScreen extends StatefulWidget {
  final bool forResetPassword;
  final String? phone;

  const SendOtpScreen({super.key, this.forResetPassword = false, this.phone});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _loading = false;
  int _secondsRemaining = 0;
  Timer? _timer;

  CountryModel? _selectedCountry;

  @override
  void initState() {
    super.initState();
    if (widget.phone != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _sendOtp());
    }
  }

  Future<String?> _getValidatedPhone() async {
    final l10n = AppLocalizations.of(context)!;
    if (widget.phone != null) return widget.phone!;

    if (!_formKey.currentState!.validate() || _selectedCountry == null) {
      return null;
    }

    final rawNumber = _phoneController.text.trim();
    final countryCode = _selectedCountry!.countryCode;

    final formattedPhone = await GatewayService.formatPhone(countryCode, rawNumber);
    if (formattedPhone == null) {
      if (mounted) {
        AppSnackbar.error(context, l10n.invalidPhoneNumber);
      }
      return null;
    }
    return formattedPhone;
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 120);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_secondsRemaining == 0) {
        t.cancel();
        setState(() {});
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _show(String? message, {bool isError = false}) {
    final translatedMsg = mapApiMessage(context, message) ?? '';
    if (isError) {
      AppSnackbar.error(context, translatedMsg);
    } else {
      AppSnackbar.success(context, translatedMsg);
    }
  }

  Future<void> _sendOtp() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _loading = true);

    final String? phone = await _getValidatedPhone();
    if (phone == null) {
      setState(() => _loading = false);
      return;
    }

    if (widget.forResetPassword) {
      final resCheck = await AuthService.checkForgotPhone(phone);
      final exists = (resCheck.data?['data']?['exists'] ?? false) as bool;
      if (!exists) {
        _show('phoneNotRegistered', isError: true);
        setState(() => _loading = false);
        return;
      }
    }

    final response = await GatewayService.sendOtp(phone: phone);

    if (!mounted) return;
    setState(() => _loading = false);

    if (response.success && response.data?.containsKey('key') == true) {
      _startCountdown();
      AppSnackbar.success(context, l10n.otpSentSuccess);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phone: phone,
            forResetPassword: widget.forResetPassword,
            otpKey: response.data!['key'],
          ),
        ),
      );
      _timer?.cancel();
      setState(() => _secondsRemaining = 0);
    } else {
      _show(response.message, isError: true);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final canResend = _secondsRemaining == 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/otp_screen.svg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 200),
                      Text(
                        widget.forResetPassword
                            ? l10n.resetPasswordTitle
                            : l10n.otpVerificationTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        l10n.sendOtpInstruction,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (widget.phone == null)
                        PhoneInputWithCountrySelector(
                          selectedCountry: _selectedCountry,
                          onCountryChanged: (c) => setState(() => _selectedCountry = c),
                          controller: _phoneController,
                          validator: (v) =>
                          v == null || v.isEmpty ? l10n.requiredField : null,
                          label: l10n.phoneNumber,
                        ),
                      if (widget.phone != null)
                        Text(
                          widget.phone!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(height: 24),
                      if (_secondsRemaining > 0)
                        Text(
                          l10n.pleaseWaitSeconds(_secondsRemaining.toString()),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        text: canResend ? l10n.sendCode : l10n.wait,
                        isLoading: _loading,
                        onPressed: canResend ? _sendOtp : null,
                      ),
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
