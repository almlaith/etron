import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../ui/theme/colors.dart';

class SearchLocationField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? initialText;
  final int debounceMs;

  const SearchLocationField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.initialText,
    this.debounceMs = 350,
  });

  @override
  State<SearchLocationField> createState() => _SearchLocationFieldState();
}

class _SearchLocationFieldState extends State<SearchLocationField> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (widget.onChanged == null) return;
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounceMs), () {
      widget.onChanged?.call(value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    const r = 14.0;
    return Material(
      elevation: 2,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(r),
      child: TextField(
        controller: _controller,
        onChanged: _onTextChanged,
        onSubmitted: (v) => widget.onSubmitted?.call(v.trim()),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 6),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF6F2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/car_charging.svg',
                  width: 16,
                  height: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF9AA0A6)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(r),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(r),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(r),
            borderSide: const BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
      ),
    );
  }
}
