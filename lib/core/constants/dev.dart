import 'package:flutter/foundation.dart';

const bool isDev = false;
const bool isAutoFillUpTextField = isDev && kDebugMode;

String firstName = isAutoFillUpTextField == true ? 'Md' : '';
String lastName = isAutoFillUpTextField == true ? 'Hasan' : '';
String email = isAutoFillUpTextField == true ? 'hasan@gmail.com' : '';
String password = isAutoFillUpTextField == true ? '!1Password' : '';
String otp = isAutoFillUpTextField == true ? '111222' : '';
String username = isAutoFillUpTextField == true ? 'username' : '';
String dob = isAutoFillUpTextField == true ? '2004-11-03' : '';
