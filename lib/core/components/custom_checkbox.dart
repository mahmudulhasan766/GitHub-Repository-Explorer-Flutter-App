import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../generated/assets.dart';
import 'custom_svg.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.height,
    this.width,
    this.margin,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected == true ? AppColors.primary400 : AppColors.gray800,
            width: .5.w,
          ),
          borderRadius: BorderRadius.circular(5.w),
        ),
        margin: margin,
        child: AnimatedContainer(
          width: width ?? 13.0.w,
          height: height ?? 13.0.h,
          decoration: BoxDecoration(
            color: isSelected == true
                ? AppColors.primary400
                : AppColors.transparent,
            border: isSelected == false
                ? Border.all(color: AppColors.gray800, width: 1.5.w)
                : null,
            borderRadius: BorderRadius.circular(5.w),
          ),
          duration: const Duration(microseconds: 200),
          child: (isSelected == true)
              ? Center(
                  child: const CustomSvg(
                    icon: Assets.iconsTickMark,
                    color: AppColors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
