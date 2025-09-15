// import 'package:flutter/material.dart';
// import '../../ui/theme/colors.dart';
//
// class SideMenuItem {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//   final Color? selectedTextColor;
//   final Color? unselectedTextColor;
//   final Color? selectedIconColor;
//   final Color? unselectedIconColor;
//   final Color? backgroundColor;
//
//   SideMenuItem({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//     this.selectedTextColor,
//     this.unselectedTextColor,
//     this.selectedIconColor,
//     this.unselectedIconColor,
//     this.backgroundColor,
//   });
// }
//
// class SideMenu extends StatelessWidget {
//   final List<SideMenuItem> items;
//   final int selectedIndex;
//   final ValueChanged<int> onItemSelected;
//   final Color? menuBackground;
//
//   const SideMenu({
//     super.key,
//     required this.items,
//     required this.selectedIndex,
//     required this.onItemSelected,
//     this.menuBackground,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       color: menuBackground ?? AppColors.backgroundDark,
//       child: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final isSelected = selectedIndex == index;
//
//           final Color selectedText = item.selectedTextColor ?? Colors.white;
//           final Color unselectedText = item.unselectedTextColor ?? AppColors.textSecondary;
//           final Color selectedIcon = item.selectedIconColor ?? AppColors.primary;
//           final Color unselectedIcon = item.unselectedIconColor ?? AppColors.textSecondary;
//           final Color selectedBackground = item.backgroundColor ?? AppColors.primary.withOpacity(0.1);
//
//           return InkWell(
//             onTap: () => onItemSelected(index),
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               decoration: BoxDecoration(
//                 color: isSelected ? selectedBackground : Colors.transparent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     item.icon,
//                     color: isSelected ? selectedIcon : unselectedIcon,
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     item.title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: isSelected ? selectedText : unselectedText,
//                       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
