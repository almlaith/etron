// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../ui/theme/colors.dart';
//
// class IsoPhoneField extends StatefulWidget {
//   const IsoPhoneField({
//     super.key,
//     required this.controller,
//     required this.onCountryChanged,
//     required this.label,
//     this.validator,
//     this.hintText,
//   });
//
//   final TextEditingController controller;
//   final Function(Country) onCountryChanged;
//   final String label;
//   final String? Function(String?)? validator;
//   final String? hintText;
//
//   @override
//   State<IsoPhoneField> createState() => _IsoPhoneFieldState();
// }
//
// class _IsoPhoneFieldState extends State<IsoPhoneField> {
//   late Country _country;
//
//   @override
//   void initState() {
//     super.initState();
//     _country = Country(
//       phoneCode: '962',
//       countryCode: 'JO',
//       e164Sc: 0,
//       geographic: true,
//       level: 1,
//       name: 'Jordan',
//       example: 'Jordan',
//       displayName: 'Jordan',
//       displayNameNoCountryCode: 'Jordan',
//       e164Key: '',
//     );
//   }
//
//   void _pickCountry() {
//     showCountryPicker(
//       context: context,
//       showPhoneCode: false,
//       favorite: const ['JO'],
//       onSelect: (c) {
//         setState(() => _country = c);
//         widget.onCountryChanged(c);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isRtl = Directionality.of(context) == TextDirection.rtl;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: Theme.of(context).textTheme.labelLarge?.copyWith(
//             color: AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: widget.controller,
//           keyboardType: TextInputType.phone,
//            validator: widget.validator,
//           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//           decoration: InputDecoration(
//             counterText: '',
//             filled: true,
//             fillColor: AppColors.surface,
//             hintStyle: const TextStyle(color: AppColors.textSecondary),
//             prefixIcon: GestureDetector(
//               onTap: _pickCountry,
//               child: Container(
//                 width: 60,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       _country.countryCode,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     const Icon(
//                       Icons.arrow_drop_down,
//                       color: AppColors.textPrimary,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.divider),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.divider),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.primary, width: 2),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.error, width: 1.5),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
