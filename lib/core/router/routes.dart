import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readback/features/home/view/repository_home_screen.dart';
import 'package:readback/features/splash/view/splash_screen.dart';
import '../../core/constants/app_strings.dart';

class Routes {
  static const String splash = "/";
  static const String dashboard = "/dashboard";
  static const String repositoryHomeScreen = "/repository_home_screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return CupertinoPageRoute(
          builder: (_) => SplashScreen(),
          settings: routeSettings,
        );
        case Routes.repositoryHomeScreen:
        return CupertinoPageRoute(
          builder: (_) => RepositoryHomeScreen(),
          settings: routeSettings,
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noPageFound.tr()),
        ),
        body: Center(
          child: Text(AppStrings.noPageFound.tr()),
        ),
      ),
    );
  }
}
