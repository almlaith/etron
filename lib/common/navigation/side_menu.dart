import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../button/primary_icon.dart';

class SideMenuItem {
  final String? icon;

  final IconData? leadingIcon;

  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  final Color? selectedColor;
  final Color? unselectedColor;
  final double iconSize;
  final Color? iconColor;

  const SideMenuItem({
    required this.title,
    required this.onTap,
    this.icon,
    this.leadingIcon,
    this.isSelected = false,
    this.selectedColor,
    this.unselectedColor,
    this.iconSize = 24,
    this.iconColor,
  });
}

class SideMenu extends StatelessWidget {
  final List<SideMenuItem> items;
  final double width;
  final Color? backgroundColor;

  const SideMenu({
    super.key,
    required this.items,
    this.width = 260,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: backgroundColor ?? AppColors.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          final Color selectedClr = item.selectedColor ?? AppColors.primary;
          final Color unselectedClr =
              item.unselectedColor ?? AppColors.textSecondary;
          final Color hover = selectedClr.withOpacity(0.1);

          Widget buildLeading() {
            if (item.icon != null) {
              return PrimaryIcon(
                icon: item.icon!,
                iconSize: item.iconSize,
                iconColor:
                    item.iconColor ??
                    (item.isSelected ? selectedClr : unselectedClr),
              );
            }
            if (item.leadingIcon != null) {
              return Icon(
                item.leadingIcon!,
                color: item.isSelected ? selectedClr : unselectedClr,
              );
            }
            return const SizedBox.shrink();
          }

          return InkWell(
            onTap: item.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: item.isSelected ? hover : Colors.transparent,
              child: Row(
                children: [
                  buildLeading(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: item.isSelected ? selectedClr : unselectedClr,
                        fontWeight: item.isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
