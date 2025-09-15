import 'dart:async';
import 'package:etron_flutter/pages/auth/otp/otp_verification_dialog.dart';
import 'package:etron_flutter/pages/auth/otp/send_otp_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../services/gateway_service.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/field/phone_input_country_selector.dart';
import '../../../common/overlays/snackbar.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/country_model.dart';
import '../../../ui/theme/colors.dart';

class PhoneVerificationDialog extends StatefulWidget {
  final bool forResetPassword;
  final void Function(String phone)? onVerified;

  const PhoneVerificationDialog({
    super.key,
    this.forResetPassword = false,
    this.onVerified,
  });

  @override
  State<PhoneVerificationDialog> createState() =>
      _PhoneVerificationDialogState();
}

class _PhoneVerificationDialogState extends State<PhoneVerificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  CountryModel? _selectedCountry;
  bool _loading = false;
  int _secondsRemaining = 0;
  Timer? _timer;

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 300);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
        setState(() {});
        AppSnackbar.error(context, AppLocalizations.of(context)!.otpExpired);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  Future<String?> _validatedPhone() async {
    final tr = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate() || _selectedCountry == null)
      return null;

    final raw = _phoneController.text.trim();
    final formatted = await GatewayService.formatPhone(
      _selectedCountry!.countryCode,
      raw,
    );

    if (formatted == null) AppSnackbar.error(context, tr.invalidPhoneNumber);
    return formatted;
  }

  Future<void> _sendOtp() async {
    final tr = AppLocalizations.of(context)!;
    setState(() => _loading = true);

    final phone = await _validatedPhone();
    if (phone == null) {
      setState(() => _loading = false);
      return;
    }

    final res = await GatewayService.sendOtp(phone: phone);
    setState(() => _loading = false);

    if (res.success && res.data?.containsKey('key') == true) {
      AppSnackbar.success(context, tr.otpSentSuccess);
      _startCountdown();

      final verified = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => OtpVerificationDialog(
          phone: phone,
          otpKey: res.data!['key'],
          forResetPassword: widget.forResetPassword,
        ),
      );

      if (verified == true) {
        widget.onVerified?.call(phone);
        if (mounted) Navigator.pop(context);
      } else {
        _timer?.cancel();
        setState(() => _secondsRemaining = 0);
      }
    } else {
      AppSnackbar.error(context, res.message ?? tr.otpSendFailGeneric);
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
    final tr = AppLocalizations.of(context)!;
    final canResend = _secondsRemaining == 0;

    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tr.sendOtpInstruction,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                PhoneInputWithCountrySelector(
                  label: tr.phoneNumber,
                  controller: _phoneController,
                  selectedCountry: _selectedCountry,
                  onCountryChanged: (c) => setState(() => _selectedCountry = c),
                  validator: (v) =>
                  v == null || v.isEmpty ? tr.requiredField : null,
                ),
                const SizedBox(height: 24),
                if (_secondsRemaining > 0)
                  Text(
                    tr.pleaseWaitSeconds(_secondsRemaining.toString()),
                    style: const TextStyle(color: AppColors.primary),
                  ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: canResend ? tr.sendCode : tr.wait,
                  isLoading: _loading,
                  onPressed: canResend ? _sendOtp : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}