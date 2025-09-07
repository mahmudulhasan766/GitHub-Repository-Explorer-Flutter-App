import 'package:flutter/material.dart';
import 'package:readback/features/theme/cubit/theme_cubit.dart';
import 'app_colors.dart'; // import your AppColors class



class ThemeColor {
  final ThemeModeStatus theme;

  const ThemeColor(this.theme);

  // Basic text and background
  Color get textColor =>
      theme == ThemeModeStatus.light ? AppColors.black : AppColors.white;

  Color get backgroundColor =>
      theme == ThemeModeStatus.light ? AppColors.white : AppColors.primary900;

  Color get cardColor =>
      theme == ThemeModeStatus.light ?  Colors.grey.shade100:const Color(0xFF1E1E1E);

  Color get borderColor =>
      theme == ThemeModeStatus.light ? AppColors.gray300 : AppColors.gray600;

  Color get iconColor =>
      theme == ThemeModeStatus.light ? AppColors.primary700 : AppColors.primary200;

  Color get headingFont =>
      theme == ThemeModeStatus.light ? AppColors.font1 : AppColors.font3;

  Color get errorColor =>
      theme == ThemeModeStatus.light ? AppColors.error1 : AppColors.error2;

  Color get successColor =>
      theme == ThemeModeStatus.light ? AppColors.success1 : AppColors.success3;

  // Gradients
  LinearGradient get buttonGradient =>
      theme == ThemeModeStatus.light ? AppColors.kButtonGradient : AppColors.kToggleButtonGradient;

  LinearGradient get headerGradient => AppColors.kHeaderGradient;

  LinearGradient get genderButtonGradient => AppColors.kGenderButtonGradient;

  LinearGradient get imageGradient => AppColors.kImageGradient;

  LinearGradient get disabledButtonGradient => AppColors().kDisableButtonGradient;

  LinearGradient get selectGradient => AppColors.selectLinearGradient;

  // Shadows
  BoxShadow get textFieldShadow => AppColors.kTextFieldShadow;

  BoxShadow get cardShadow =>
      theme == ThemeModeStatus.light ? AppColors.cardShadow : AppColors.cardShadow2;

  BoxShadow get circularButtonShadow => AppColors.kCircularButtonShadow;

  BoxShadow get circularNotificationButtonShadow =>
      AppColors.kCircularNotificationButtonShadow;

  BoxShadow get circularNotificationCardShadow =>
      AppColors.kCircularNotificationCardShadow;

  BoxShadow get ordinaryShadow => AppColors.kOrdinaryShadow;

  BoxShadow get backgroundShadow =>
      theme == ThemeModeStatus.light ? AppColors.backgroundShadow : AppColors.kBackGroundShadow;

  BoxShadow get backgroundShadowProfile => AppColors.kBackGroundShadowProfile;

  BoxShadow get productCardShadow => AppColors.cardShadowProduct;

  BoxShadow get backgroundShadow2 => AppColors.kBackGroundShadow2;

  // Decorations
  BoxDecoration get backgroundBoxDecoration =>
      theme == ThemeModeStatus.light
          ? AppColors.backgroundGreyShadow100
          : AppColors.backgroundGreyShadow50;
}
