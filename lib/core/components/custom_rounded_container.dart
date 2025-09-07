import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomRoundedContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget icon;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;

  const CustomRoundedContainer({
    super.key,
    required this.icon,
    this.onTap,
    this.color = AppColors.white, // Default color
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 50.0, // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius!).r,
          border: Border.all(
            color: borderColor ?? AppColors.gray100,
            // Default border color
            width: borderWidth!,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withValues(alpha:0.5), // Shadow color with opacity
          //     //spreadRadius: 1, // Spread radius
          //    // blurRadius: 1, // Blur radius
          //     offset: Offset(1, 2), // Shadow position (x, y)
          //   ),
          // ],
        ),
        child: icon,
      ),
    );
  }
}
