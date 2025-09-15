import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';

class AppTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController controller;
  final Color? indicatorColor;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: indicatorColor ?? AppColors.success,
      indicatorWeight: 4.0,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}