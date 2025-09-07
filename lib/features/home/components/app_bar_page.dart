import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarPage extends StatelessWidget {
  final String? title;
  final Color? bgColor;
  final bool isActionEnable;
  final bool isCartEnable;

  const AppBarPage({
    super.key,
    this.title,
    this.bgColor,
    this.isActionEnable = true,
    this.isCartEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: REdgeInsets.symmetric(horizontal: 20.w),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
