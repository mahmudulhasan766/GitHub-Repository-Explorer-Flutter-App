import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/core/components/custom_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.gradient,
    this.isGradientColor = true,
    // this.isBorder = false,
    this.border,
    this.borderColor = AppColors.gray300,
    this.borderRadius,
    this.onTap,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.isPrefixEnable = false,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  final String title;
  final Gradient? gradient;
  final bool isGradientColor;
  // final bool isBorder;
  final Border? border;
  final Color borderColor;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool isPrefixEnable;
  final String? icon;
  final double? iconSize;
  final double? borderRadius;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ??
        kBodyMediumSemibold.copyWith(
          color: textColor ??
              (onTap != null ? AppColors.white : AppColors.gray300),
        );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor ??
                (onTap != null ? AppColors.primary700 : AppColors.gray100),
            gradient: isGradientColor
                ? gradient ??
                    (onTap != null
                        ? AppColors.kButtonGradient
                        : LinearGradient(
                            colors: [
                              const Color(0xFF4E54CB).withValues(alpha: .2),
                              const Color(0xFF17A0B2).withValues(alpha: 0.186),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ))
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            border: border
            // border: isBorder
            //     ? border ?? Border.all(color: borderColor, width: 1)
            //     : null,
            ),
        child: isPrefixEnable
            ? _buildIconAndText(textStyle)
            : Text(title, style: textStyle),
      ),
    );
  }

  Row _buildIconAndText(TextStyle textStyle) {
    final isIconSvg = icon!.toLowerCase().endsWith('.svg');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isIconSvg)
          CustomSvg(
            icon: icon!,
            size: iconSize ?? 24.r,
            color: iconColor,
          ),
        if (!isIconSvg)
          Image.asset(
            icon!,
            height: 24.r,
            width: 24.r,
            errorBuilder: (context, error, stackTrace) => Text(
              title[0],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        10.horizontalSpace,
        Text(title, style: textStyle)
      ],
    );
  }
}
