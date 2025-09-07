import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import 'custom_svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: const CustomSvg(icon: Assets.iconsBackButton),
    );
  }
}
