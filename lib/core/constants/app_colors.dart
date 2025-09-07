import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  /// ---------------------------------------------------------------------------
  /// Primary Colors
  ///
  /// A curated palette of primary brand colors used throughout the application.
  /// These colors represent the main identity and are used for key UI elements
  /// such as buttons, links, and highlights.
  ///
  /// Usage:
  ///   - Main action buttons
  ///   - App bars and navigation
  ///   - Highlights and accents
  ///
  /// Consistent use of these primary colors helps reinforce brand recognition
  /// and provides a visually appealing interface.
  /// ---------------------------------------------------------------------------

  static const progressColor = Color(0xFF030461);
  static const progressBackgroundColor = Color(0xFF0078B6);
  static const primary950 = Color(0xFF102641);
  static const primary900 = Color(0xFF183C62);
  static const primary800 = Color(0xFF164676);
  static const primary700 = Color(0xFF01549B);
  static const primary600 = Color(0xFF1967B0);
  static const primary500 = Color(0xFF2883CF);
  static const primary400 = Color(0xFF3C95DE);
  static const primary300 = Color(0xFF8CC0ED);
  static const primary200 = Color(0xFFC2DDF5);
  static const primary100 = Color(0xFFE4EEFA);
  static const primary50 = Color(0xFFF2F7FD);

  static const primaryBackground1 = Color(0xFF81CCED);
  static const primaryBackground2 = Color(0xFF4A94D1);

  static const gray950 = Color(0xFF363636);
  static const gray900 = Color(0xFF545454);
  static const gray800 = Color(0xFF676767);
  static const gray700 = Color(0xFF7B7B7B);
  static const gray600 = Color(0xFF888888);
  static const gray500 = Color(0xFF999999);
  static const gray400 = Color(0xFFADADAD);
  static const gray300 = Color(0xFFC8C8C8);
  static const gray200 = Color(0xFFD9D9D9);
  static const gray100 = Color(0xFFEDEDED);
  static const gray50 = Color(0xFFF7F7F7);

  // Font Colors
  static const font1 = Color(0xFF092357);
  static const font2 = Color(0xFF284980);
  static const font3 = Color(0xFF7599D4);

  static const error1 = Color(0xFFE53535);
  static const error2 = Color(0xFFFF5C5C);
  static const error3 = Color(0xFFFF8080);

  static const success1 = Color(0xFF05A660);
  static const success2 = Color(0xFF05A660);
  static const success3 = Color(0xFF39D98A);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const transparent = Colors.transparent;
  static const shadowColor = Color(0xFF262740);

  static const dark1 = Color(0xFF3A3A3C);

  static const kButtonGradient = LinearGradient(
    colors: [Color(0xFF4E54C8), Color(0xFF17A0B2)], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kHeaderGradient = LinearGradient(
    colors: [Color(0xFF391995), Color(0xFF11A9EA)], // Blue and purple gradient
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0],
  );

  static const kGenderButtonGradient = LinearGradient(
    colors: [Color(0xFF5632BD), Color(0xFF33B1E7)], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kToggleButtonGradient = LinearGradient(
    colors: [Color(0xFF4E54C8), Color(0xFF17A0B2)], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  LinearGradient kDisableButtonGradient = LinearGradient(
    colors: [
      const Color(0xFF4E54CB).withValues(alpha: 0.2),
      const Color(0xFF17A0B2).withValues(alpha: 0.186)
    ], // Blue and purple gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const kImageGradient = LinearGradient(
    colors: [Color(0xFF070B34), Color(0xFF5E7BD3)], // Blue and purple gradient
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [1.0, 0.0],
  );

  static final kTextFieldShadow = BoxShadow(
    color: shadowColor.withValues(alpha: 0.07),
    offset: const Offset(0, 2), // Horizontal and Vertical offset
    blurRadius: 32, // Blur radius
    spreadRadius: 0,
  );

  static final kCircularButtonShadow = BoxShadow(
    color: AppColors.gray950.withValues(alpha: .1),
    spreadRadius: 4,
    blurRadius: 4,
    offset: const Offset(0, 1),
  );

  static final kCircularNotificationButtonShadow = BoxShadow(
    color: AppColors.black.withValues(alpha: .28),
    blurRadius: 107,
    offset: const Offset(3, 10),
  );

  static final kCircularNotificationCardShadow = BoxShadow(
    color: const Color(0xFF282828).withValues(alpha: .05),
    blurRadius: 52,
    offset: const Offset(0, 8),
  );

  static final kOrdinaryShadow = BoxShadow(
    color: gray950.withValues(alpha: .12),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );

  static final kBackGroundShadow = BoxShadow(
    color: const Color(0xFFABB0AC).withValues(alpha: 0.25),
    blurRadius: 70,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final kBackGroundShadowProfile = BoxShadow(
    color: const Color(0xFFE0E1E0).withValues(alpha: 0.4),
    offset: const Offset(0, 4),
    blurRadius: 50.r,
    spreadRadius: 0,
  );

  static final backgroundShadow = BoxShadow(
    color: const Color(0xFFE0E1E0).withValues(alpha: 0.8),
    blurRadius: 52,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final cardShadow = BoxShadow(
    color: gray200.withValues(alpha: 0.9),
    blurRadius: 30,
    offset: const Offset(0, 4),
    spreadRadius: 0,
  );

  static final cardShadowProduct = BoxShadow(
    color: black.withValues(alpha: 0.05),
    blurRadius: 27,
    offset: const Offset(2, 4),
    spreadRadius: 0,
  );

  static final cardShadow2 = BoxShadow(
    color: const Color(0xFF000000).withValues(alpha: 0.05),
    blurRadius: 30,
    offset: const Offset(2, 4),
    spreadRadius: 0,
  );

  static final BoxDecoration backgroundGreyShadow100 = BoxDecoration(
    color: gray100,
    borderRadius: BorderRadius.circular(8).r,
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFE0E1E0).withValues(alpha: 0.4),
        blurRadius: 52,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );

  static final BoxDecoration backgroundGreyShadow50 = BoxDecoration(
    color: gray50,
    borderRadius: BorderRadius.circular(8).r,
    boxShadow: [
      BoxShadow(
        color: const Color(0xFFE0E1E0).withValues(alpha: 1),
        blurRadius: 52,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      )
    ],
  );

  static const selectLinearGradient = LinearGradient(
    colors: [Color(0xFF5632BD), Color(0xFF33b1E7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final kBackGroundShadow2 = BoxShadow(
    color: gray400.withValues(alpha: 0.4),
    blurRadius: 52,
    offset: const Offset(0, 4),
  );
}
