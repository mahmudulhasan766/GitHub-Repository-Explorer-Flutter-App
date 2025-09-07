import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CommonLine extends StatelessWidget {
  final double height;
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry? margin;

  const CommonLine({
    super.key,
    this.height = 24.0, // Default height
    this.color = AppColors.gray100, // Default color
    this.thickness = 1.0, // Default thickness
    this.margin, // Optional margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: thickness,
      color: color,
      margin: margin,
    );
  }
}
