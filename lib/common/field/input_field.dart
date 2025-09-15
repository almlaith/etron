import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/theme/colors.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final Color? fillColor;
  final AutovalidateMode? autovalidateMode;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.keyboardType,
    this.borderColor,
    this.fillColor,
    this.autovalidateMode,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late AutovalidateMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.autovalidateMode ?? AutovalidateMode.disabled;

    widget.controller.addListener(() {
      if (_mode == AutovalidateMode.always) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autovalidateMode != oldWidget.autovalidateMode) {
      setState(() => _mode = widget.autovalidateMode ?? AutovalidateMode.disabled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorder = widget.borderColor ?? AppColors.divider;
    final Color effectiveFill = widget.fillColor ?? AppColors.surface;

    return TextFormField(
      autovalidateMode: _mode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      maxLength: widget.maxLength,
      onChanged: (val) {
        widget.onChanged?.call(val);
        if (_mode == AutovalidateMode.always) {
          setState(() {});
        }
      },
      keyboardType: widget.keyboardType,
      inputFormatters: (widget.keyboardType == TextInputType.phone || widget.keyboardType == TextInputType.number)
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
         hintStyle: TextStyle(color: AppColors.grayLight),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        counterText: '',
        filled: true,
        fillColor: effectiveFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: effectiveBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: effectiveBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}