import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.title,
    this.textStyle,
    this.isRequired = true,
  });

  final String title;
  final TextStyle? textStyle;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Flexible(
            child: Text(
              title,
              style: textStyle ??
                  kBodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (isRequired)
            Transform.translate(
              offset: const Offset(2, -2),
              child: Text(
                "*",
                style:
                    kBodyMediumSemibold.copyWith(color: AppColors.primary400),
              ),
            )
        ],
      ),
    );
  }
}
