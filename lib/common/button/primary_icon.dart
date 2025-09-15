  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import '../../ui/theme/colors.dart';

  class PrimaryIcon extends StatelessWidget {
    final String icon;
    final double iconSize;
    final Color? iconColor;

    const PrimaryIcon({
      super.key,
      required this.icon,
      this.iconSize = 24,
      this.iconColor,
    });

    @override
    Widget build(BuildContext context) {
      return SvgPicture.asset(
        icon,
        width: iconSize,
        height: iconSize,
        colorFilter: ColorFilter.mode(
          iconColor ?? AppColors.primary,
          BlendMode.srcIn,
        ),
      );
    }
  }

