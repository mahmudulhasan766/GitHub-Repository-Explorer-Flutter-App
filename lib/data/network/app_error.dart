import 'package:readback/core/constants/app_print.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app/app_flavor.dart';

late SharedPreferences prefs;

class AppError {
  String line = "=====================================";
  void logError(Object error, StackTrace stackTrace) {
    printLog('Caught error: $error\n$stackTrace ');
    printLog(stackTrace.toString());
  }

  Future<void> allAppError(
      {error, message, from = "app", color, requestParams}) async {
    prefs = await SharedPreferences.getInstance();
  }

  String getColor() {
    if (AppFlavor.getFlavor == FlavorStatus.production) {
      return "FF0000";
    } else if (AppFlavor.getFlavor == FlavorStatus.development) {
      return "#DFFF00";
    } else {
      return "#FF69B4";
    }
  }
}
