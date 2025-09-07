import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAndroidStatusBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? color;

  const CustomAndroidStatusBar({super.key, this.color});

  @override
  Size get preferredSize => Size.fromHeight(0.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: color ?? Colors.transparent),
    );
  }
}
