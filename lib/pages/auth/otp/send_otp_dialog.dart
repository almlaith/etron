import 'dart:async';
import 'package:flutter/material.dart';
import '../../../services/gateway_service.dart';
import '../../../common/button/primary_button.dart';
import '../../../common/field/input_field.dart';
import '../../../l10n/app_localizations.dart';
import '../../../ui/theme/colors.dart';

class OtpVerificationDialog extends StatefulWidget {
  final String phone;
  final String otpKey;
  final bool forResetPassword;

  const OtpVerificationDialog({
    super.key,
    required this.phone,
    required this.otpKey,
    this.forResetPassword = false,
  });

  @override
  State<OtpVerificationDialog> createState() => _OtpVerificationDialogState();
}

class _OtpVerificationDialogState extends State<OtpVerificationDialog> {
  final _otpController = TextEditingController();
  int _secondsLeft = 300;
  Timer? _timer;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    setState(() => _secondsLeft = 300);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
        if (mounted) {
          setState(() {});
          _show(AppLocalizations.of(context)!.otpExpired);
        }
      } else {
        if (mounted) setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verifyOtp() async {
    final tr = AppLocalizations.of(context)!;
    final code = _otpController.text.trim();

    if (_secondsLeft <= 0) {
      _show(tr.otpExpired);
      return;
    }

    if (code.length != 4) return;

    setState(() => _loading = true);

    final res = await GatewayService.verifyOtp(key: widget.otpKey, otp: code);

    if (res.success) {
      Navigator.pop(context, true);
    } else {
      _show(tr.incorrectOtp);
    }

    if (mounted) setState(() => _loading = false);
  }

  void _show(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: AppColors.error),
  );

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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr.otpSentTo(widget.phone.replaceRange(3, 9, '******')),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              InputField(
                label: tr.verificationCode,
                controller: _otpController,
                hintText: tr.enterVerificationCode,
                maxLength: 4,
                keyboardType: TextInputType.number,
                onChanged: (v) => v.length == 4 ? _verifyOtp() : null,
              ),
              const SizedBox(height: 12),
              Text(
                tr.codeExpiresIn('$minutes:$seconds'),
                style: TextStyle(
                  color: _secondsLeft <= 0 ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: tr.verify,
                isLoading: _loading,
                onPressed: _verifyOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}