import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;
  final BoxFit? fit;

  const CustomSvg({
    super.key,
    required this.icon,
    this.color,
    this.fit,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return icon.contains("http")
        ? SvgPicture.network(
            icon,
            color: color,
            height: size ?? 24.r,
            width: size ?? 24.r,
            fit: fit ?? BoxFit.contain,
          )
        : SvgPicture.asset(
            icon,
            color: color,
            height: size ?? 24.r,
            width: size ?? 24.r,
            fit: fit ?? BoxFit.contain,
          );
  }
}
