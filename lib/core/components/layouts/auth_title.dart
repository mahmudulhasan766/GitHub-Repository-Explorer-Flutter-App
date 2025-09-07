import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_style.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        10.verticalSpace,
        Text(
          title,
          style: kHeading4.copyWith(color: AppColors.font1),
        ),
        if(subtitle != null) Text(
          subtitle!,
          style: kBodyRegularRegular.copyWith(
            color: AppColors.font2,
          ),
        ),
      ],
    );
  }
}
