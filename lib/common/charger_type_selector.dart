// import 'package:flutter/material.dart';
// import '../../../ui/theme/colors.dart';
//
//  class ChargerTypeSelector extends StatefulWidget {
//   final List<String> options;
//   final ValueChanged<String> onChanged;
//
//   const ChargerTypeSelector({
//     super.key,
//     required this.options,
//     required this.onChanged,
//   });
//
//   @override
//   State<ChargerTypeSelector> createState() => _ChargerTypeSelectorState();
// }
//
// class _ChargerTypeSelectorState extends State<ChargerTypeSelector> {
//   int _selected = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(widget.options.length, (i) {
//           final bool isSel = i == _selected;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: ChoiceChip(
//               label: Text(widget.options[i]),
//               selected: isSel,
//               labelStyle: TextStyle(
//                 color: isSel ? Colors.white : Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//               selectedColor: AppColors.primary,
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(
//                   color: isSel ? AppColors.primary : Colors.grey.shade300,
//                 ),
//               ),
//               onSelected: (_) {
//                 setState(() => _selected = i);
//                 widget.onChanged(widget.options[i]);
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
