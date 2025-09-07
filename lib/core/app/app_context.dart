import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readback/features/home/view/repository_home_screen.dart';

class AppContext {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Object? get argument => ModalRoute.of(context)!.settings.arguments;
  static final GlobalKey key = GlobalKey();

  final ValueNotifier<bool> isPortrait = ValueNotifier<bool>(true);

  static Size size() => context.size!;

  static PageRouteBuilder _customPageRoute(Widget page,
      {Duration duration = const Duration(milliseconds: 300)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static Future<void> to(Widget page, {dynamic arguments}) {
    if (kDebugMode) log('Navigate To: ${page.runtimeType}');

    return Navigator.of(context, rootNavigator: false)
        .push(_customPageRoute(page));
  }

  static Future<void> toNamed({String? route, dynamic arguments}) {
    return Navigator.of(context).pushNamed(route!, arguments: arguments);
  }

  static String
      toRestorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(context).restorablePopAndPushNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static void back([dynamic result]) {
    Navigator.of(context).pop(result);
  }

  static void backOff([dynamic result]) {
    Navigator.of(context).popUntil(result);
  }

  static Future<void> offAll(String route, {dynamic arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        route, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static Future<void> pushAndRemoveUntil(String routeName,
      {dynamic arguments}) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) {
        return _getPage(routeName, arguments);
      }),
      (Route<dynamic> route) => false,
    );
  }

// Helper method to get the widget for a given route name
  static Widget _getPage(String routeName, dynamic arguments) {
    switch (routeName) {
      case '/home':
        return RepositoryHomeScreen();
      default:
        return const RepositoryHomeScreen();
    }
  }

  static Future<void> toReplace(Widget page) {
    if (kDebugMode) log('Navigate To: ${page.runtimeType}');

    return Navigator.pushReplacement(context, _customPageRoute(page));
  }

  static Future<void> openDialog(
    Widget dialog, {
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Align(
          alignment: alignment,
          child: dialog,
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(
                0, 1), // Start position, modify for different directions
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  static void offAllAndToNamed(String route, {dynamic arguments}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (_) => false, arguments: arguments);
  }

  static Future<void> openBottomSheet(Widget bottomSheet) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => bottomSheet,
    );
  }

  static void showSnackBar(String message, {int durationInSeconds = 4}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: durationInSeconds),
    ));
  }

  static Future<void> toRoot() {
    Completer<void> completer = Completer<void>(); // Create a Completer
    Navigator.of(context).popUntil((route) {
      if (route.isFirst) {
        completer
            .complete(); // Complete the future when the first route is reached
      }
      return route.isFirst;
    });
    return completer.future; // Return the future
  }
}
