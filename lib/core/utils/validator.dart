import 'package:easy_localization/easy_localization.dart';

import '../constants/app_strings.dart';
import '../constants/strings.dart';

final nameRegExp = RegExp(r"^[a-zA-Z-' ]+$");

class Validator {
  static String? firstName(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return AppStrings.firstNameEmptyErr.tr();
    }

    if (v.trim() != v) {
      return AppStrings.firstNameLeadingOrTrailingSpaceErr.tr();
    }

    if (!nameRegExp.hasMatch(v)) {
      return AppStrings.firstNameInvalidCharErr.tr();
    }

    if (v.length < 2) return AppStrings.firstNameMinLengthErr.tr();

    if (v.length > 30) return AppStrings.firstNameMaxLengthErr.tr();

    return null;
  }

  static String? lastName(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return AppStrings.lastNameEmptyErr.tr();
    }

    if (v.trim() != v) {
      return AppStrings.lastNameLeadingOrTrailingSpaceErr.tr();
    }

    if (!nameRegExp.hasMatch(v)) {
      return AppStrings.lastNameInvalidCharErr.tr();
    }

    if (v.length < 2) return AppStrings.lastNameMinLengthErr.tr();

    if (v.length > 30) return AppStrings.lastNameMaxLengthErr.tr();

    return null;
  }

  static String? email(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return AppStrings.emailEmptyErr.tr();
    }

    if (!emailValidatorRegExp.hasMatch(v)) {
      return AppStrings.emailInvalidErr.tr();
    }

    return null;
  }

  static String? password(String? v) {
    if (v == null || v == '') {
      return AppStrings.passwordEmptyErr.tr();
    }

    if (v.length > 20) return AppStrings.passwordMaxLengthErr.tr();

    if (v.length < 6) return AppStrings.passwordMinLengthErr.tr();

    if (!v.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercaseCharErr.tr();
    }

    if (!v.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordLowercaseCharErr.tr();
    }

    if (!v.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordNumberCharErr.tr();
    }

    if (!v.contains(RegExp(r'[~!@#$%^&*()_+`{}|<>?;:.,=[\]\\/\-]'))) {
      return AppStrings.passwordSpecialCharErr.tr();
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null ||
        confirmPassword == '' ||
        confirmPassword.trim() == '') {
      return AppStrings.confirmPasswordEmptyErr.tr();
    }

    if (confirmPassword != password) {
      return AppStrings.passwordsDoNotMatchErr.tr();
    }

    return null;
  }

  /* static String? phone(String? v) {
    if (v == null || v == '') {
      return AppStrings.provideValidNumber.tr();
    }

    if (!mobileNumberRegex.hasMatch(v)) {
      return AppStrings.provideValidNumber.tr();
    }

    return null;
  } */

  /* static String? companyName(String? v) {
    if (v == null || v == '') return null;

    if (v.length > 100) {
      return AppStrings.checkoutAddressCompanyNameMax100Char.tr();
    }

    return null;
  } */

  /* static String? country(String? v) {
    if (v == null || v == '') {
      return AppStrings.checkoutAddressCountryOrRegionRequired.tr();
    }

    if (v.length > 100) {
      return AppStrings.checkoutAddressCountryOrRegionMax100.tr();
    }

    return null;
  } */

  /* static String? street(String? v) {
    if (v == null || v == '') {
      return AppStrings.checkoutAddressStreetRequired.tr();
    }

    if (v.length > 100) return AppStrings.checkoutAddressStreetMax100.tr();

    return null;
  } */

  /* static String? city(String? v) {
    if (v == null || v == '') {
      return AppStrings.checkoutAddressLocationOrCityRequired.tr();
    }

    if (v.length > 100) {
      return AppStrings.checkoutAddressLocationOrCityMax100.tr();
    }

    return null;
  } */

  /* static String? postCode(String? v) {
    if (v == null || v == '') {
      return AppStrings.checkoutAddressPostalCodeRequired.tr();
    }

    if (v.length > 100) return AppStrings.checkoutAddressPostalCodeMax100.tr();

    return null;
  } */

  /* 
  static String? comments(String? v) {
    if (v == null || v == '') return null;

    if (v.length > 500) return AppStrings.checkoutAddressCommentsMax500.tr();

    return null;
  } 
  */

  /* static String? dob(String? v) {
    if (v == null || v == '') {
      return AppStrings.signUpDobRequiredErr.tr();
    }

    return null;
  } */

  /* static String? fullName(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return AppStrings.firstNameEmptyErr.tr();
    }

    if (!nameRegExp.hasMatch(v)) {
      return AppStrings.firstNameEmptyErr.tr();
    }

    final isHeiFan = v.split('').every((char) => char == '\'');
    final isDot = v.split('').every((char) => char == '-');

    if (isHeiFan == true || isDot == true) {
      return AppStrings.firstNameEmptyErr.tr();
    }

    if (v.length < 2) return AppStrings.firstNameMinLengthErr.tr();

    if (v.length > 30) return AppStrings.firstNameEmptyErr.tr();

    return null;
  } */
}
