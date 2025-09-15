import 'package:flutter/material.dart';
import 'package:etron_flutter/ui/theme/colors.dart';

class GroupCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  const GroupCard({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(height: 1, color: AppColors.divider),
          ],
        ],
      ),
    );
  }
}
