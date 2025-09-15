// // lib/ui/home/widgets/search_location_input.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../ui/theme/colors.dart';
// import '../../../l10n/app_localizations.dart';
//
// /// شريط البحث العلوي (Where do you want to charge?)
// class SearchLocationInput extends StatelessWidget {
//   final TextEditingController controller;
//   const SearchLocationInput({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: const [
//           BoxShadow(
//             blurRadius: 6,
//             offset: Offset(0, 2),
//             color: Colors.black12,
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         textInputAction: TextInputAction.search,
//         decoration: InputDecoration(
//           hintText: l10n.searchLocation,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 14),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SvgPicture.asset(
//               'assets/icons/charger.svg',
//               width: 24,
//               color: AppColors.primary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
