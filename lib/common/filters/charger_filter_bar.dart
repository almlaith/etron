import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // لإضافة دعم SVG
import '../../ui/theme/colors.dart';

class ChargerFilterBar extends StatelessWidget {
  final List<String> chargerTypes;
  final String? selectedType;
  final ValueChanged<String> onTypeSelected;
  final VoidCallback? onFilterTap;

  const ChargerFilterBar({
    super.key,
    required this.chargerTypes,
    required this.selectedType,
    required this.onTypeSelected,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/icons/filter-list.svg',
              width: 20,
              height: 20,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: chargerTypes.map((type) {
                final bool isSelected = selectedType == type;
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: ChoiceChip(
                    label: Text(type),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    selected: isSelected,
                    onSelected: (_) => onTypeSelected(type),
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
