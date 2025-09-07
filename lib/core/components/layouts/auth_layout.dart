import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/core/components/layouts/auth_title.dart';

import '../../../generated/assets.dart';
import '../../constants/app_colors.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.child,
    required this.pageName,
    this.subtitle,
    this.actions,
    this.leading,
    this.title,
  });

  final String pageName;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget child;
  final Widget? leading;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary50, AppColors.primary300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              pinned: true,
              floating: true,
              snap: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary700,
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesAuthCover),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFFDAEAFB), Color(0xFFDAEAFB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: AuthTitle(title: pageName, subtitle: subtitle),
                ),
              ),
              leading: leading,
              title: title,
              actions: actions,
            ),
            SliverToBoxAdapter(child: child),
          ],
        ),
      ),
    );
  }
}
