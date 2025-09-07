import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/core/constants/app_colors.dart';
import 'package:readback/core/constants/app_text_style.dart';

import '../../../../../core/components/circle_button.dart';
import '../../../../../generated/assets.dart';

class InnerLayout extends StatelessWidget { 
  const InnerLayout({super.key, required this.child,  this.isBackgroundImage = true});

  final Widget child;
  final bool isBackgroundImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary700,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: isBackgroundImage? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesAuthCover),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ):null,
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: [
                CircleButton(),
                16.horizontalSpace,
                Text(
                  'Basic Level',
                  style: kBodyLarge.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.86,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
                gradient:isBackgroundImage? LinearGradient(
                  colors: [
                    AppColors.primary50,
                    AppColors.primary300,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ):null,
              ),
              padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
