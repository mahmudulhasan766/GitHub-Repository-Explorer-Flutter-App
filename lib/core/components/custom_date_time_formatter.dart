import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import '../../core/app/app_context.dart';

extension DateTimeExtensions on DateTime {
  String get formattedDate {
    // List of month names
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    // Fetch the month name using the month index
    String monthName = monthNames[month - 1];

    // Construct the formatted date string
    return "$day $monthName, $year";
  }

  String get toNameDate {
    return DateFormat('dd.MM.yyyy', AppContext.context.locale.languageCode)
        .format(this);
    // something like 26 Nov 2023, 12:10
  }

  DateTime convertLocalToUtc() {
    final localOffset = timeZoneOffset;
    const utcOffset = Duration(hours: 0);
    final offset = utcOffset - localOffset;
    return add(offset);
  }

  DateTime convertUtcToLocalTime() {
    final localDateTime = toLocal();
    return DateTime(
        localDateTime.year,
        localDateTime.month,
        localDateTime.day,
        localDateTime.hour,
        localDateTime.minute,
        localDateTime.second,
        localDateTime.millisecond,
        localDateTime.microsecond);
  }

  int getAge({DateTime? comparedTo}) {
    comparedTo ??= DateTime.now();
    int years = comparedTo.year - year;
    if (comparedTo.month < month ||
        (comparedTo.month == month && comparedTo.day < day)) {
      years--;
    }
    return years;
  }
}

extension CurrencyFormatter on num {
  String formatCurrency() {
    NumberFormat formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(this).replaceAll(',', "’");
  }
}

class CustomTimeFormatter {
  static String toYearMonthDateFormat(String? dateTime) {
    return DateFormat('yyyy-MM-dd', AppContext.context.locale.languageCode)
        .format(DateTime.parse(dateTime ?? DateTime.now().toString()));
    // something like 2023-12-30
  }

  static String toDateMonthFormat(String? dateTime) {
    return DateFormat('dd-MM-yyyy', AppContext.context.locale.languageCode)
        .format(DateTime.parse(dateTime ?? DateTime.now().toString()));
    // something like 2023-12-30
  }

  static String toDateMonthYearTimeFormat(DateTime? dateTime) {
    return DateFormat(
            'dd MMM yyyy, HH:mm', AppContext.context.locale.languageCode)
        .format(dateTime ?? DateTime.now());
    // something like 26 Nov 2023, 12:10
  }

  static String toDDMMYY(DateTime? dateTime) {
    return DateFormat('dd MMM yyyy', AppContext.context.locale.languageCode)
        .format(dateTime ?? DateTime.now());
    // something like 26 Nov 2023, 12:10
  }

  static String toDateMonthYearFormat(String? dateTime) {
    return DateFormat('dd. MMM yyyy', AppContext.context.locale.languageCode)
        .format(DateTime.parse(dateTime ?? DateTime.now().toString()));
    // something like 12 Sep, 2023
  }

  static String toDDMMYYYYFormat(String? dateTime) {
    return DateFormat('dd.MM.yyyy', AppContext.context.locale.languageCode)
        .format(DateTime.parse(dateTime ?? DateTime.now().toString()));
    // something like 12 Sep, 2023
  }

  static bool isPreviousDate(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();

    if (selectedDate.isAfterOrEqualTo(currentDate) || selectedDate.isToday()) {
      return false;
    } else {
      return true;
    }
  }

  static String time(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      final DateFormat formatter = DateFormat('Hm');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "Running";
    }

    // something like 2013-04-20
  }

  static String time12(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      final DateFormat formatter = DateFormat('hh:mm a');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "Running";
    }

    // something like 2013-04-20
  }

  static bool dateRangesOverlap(
      DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    start1.isBefore(end2) && end1.isAfter(start2);
    start2.isBefore(end1) && end2.isAfter(end1);

    return DateTime(start2.year, start2.month, start2.day, start2.hour,
                start2.minute, start2.second)
            .isBefore(DateTime(end1.year, end1.month, end1.day, end1.hour,
                end1.minute, end1.second)) &&
        DateTime(end2.year, end2.month, end2.day, end2.hour, end2.minute,
                end2.second)
            .isAfter(DateTime(end1.year, end1.month, end1.day, end1.hour,
                end1.minute, end1.second));
  }

  static DateTime? dateConverter(String date) {
    return DateTime.parse(date);
  }

  static DateTime replaceDate(String originDateTime, DateTime newDate) {
    DateTime originalDateTime = DateTime.parse(originDateTime);
    DateTime.parse(originDateTime).toUtc();

    return DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      originalDateTime.hour,
      originalDateTime.minute,
      originalDateTime.second,
      originalDateTime.millisecond,
      originalDateTime.microsecond,
    ).toUtc();
  }

  static bool isBetweenDate(
      DateTime date1, DateTime date2, DateTime startDate, DateTime endDate) {
    final selectedDate1 = DateTime(date1.year, date1.month, date1.day,
        date1.hour, date1.minute, date1.second);
    final selectedDate2 = DateTime(date2.year, date2.month, date2.day,
        date2.hour, date2.minute, date2.second);
    final start = DateTime(startDate.year, startDate.month, startDate.day,
        startDate.hour, startDate.minute, startDate.second);
    final end = DateTime(endDate.year, endDate.month, endDate.day, endDate.hour,
        endDate.minute, endDate.second);

    if (selectedDate1.isAfter(start) && selectedDate1.isBefore(end) ||
        selectedDate1 == startDate ||
        selectedDate1 == endDate) {
      return true;
    } else if (selectedDate2.isAfter(start) && selectedDate2.isBefore(end) ||
        selectedDate2 == startDate ||
        selectedDate2 == endDate) {
      return true;
    } else {
      return false;
    }
  }

  static bool isBetween(DateTime date, List<dynamic> dateRanges) {
    for (var dateRange in dateRanges) {
      if (date.isAfter(DateTime.parse(dateRange['start_time']!)) &&
          date.isBefore(DateTime.parse(dateRange['end_time']!))) {
        return true;
      }
    }
    return false;
  }

  static bool isOverlapRange(
      {String? start1, String? end1, List<dynamic>? dateRanges}) {
    DateTime start_1 = DateTime.parse(start1.toString());
    DateTime end_1 = DateTime.parse(end1.toString());

    log("from method n ------------> $start_1");
    log("from method n2 ------------> $end_1");
    log("from method ------------> $dateRanges");

    for (var i = 0; i < dateRanges!.length; i++) {
      var start2 = DateTime.parse(dateRanges[i]['start_time']);
      var end2 = DateTime.parse(dateRanges[i]['end_time']);

      log("from method x ------------> $start2");
      log("from method x2 ------------> $end2");

      if (start_1.isBeforeOrEqualTo(end2) && end_1.isAfterOrEqualTo(start2) ||
          start_1.isAfterOrEqualTo(start2) && end_1.isBeforeOrEqualTo(end2)) {
        log(true.toString());
        return true; // overlap found
      }
    }
    return false; // no overlap found
  }

  static String hour(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      final DateFormat formatter =
          DateFormat('HH', AppContext.context.locale.toString());
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "Running";
    }

    // something like 2013-04-20
  }

  static String timeHMS(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);
      final DateFormat formatter =
          DateFormat('HH:mm:ss', AppContext.context.locale.toString());
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "Running";
    }

    // something like 2013-04-20
  }

  static String timeHM(String? dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime ?? DateTime.now().toString());
      final DateFormat formatter =
          DateFormat('HH:mm', AppContext.context.locale.toString());
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "Running";
    }

    // something like 2013-04-20
  }

  static String timeUtc(String dateTime) {
    try {
      DateTime date = DateTime.parse(dateTime);

      String dateFormatted =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date);

      return dateFormatted;
    } catch (e) {
      return "";
    }

    // something like 2013-04-20
  }

  static DateTime recentMonday(DateTime dateTime) {
    DateTime mostRecentMonday = DateTime(
        dateTime.year, dateTime.month, dateTime.day - (dateTime.weekday - 1));

    return mostRecentMonday;

    // something like 2013-04-20
  }

  static bool isCurrentDateInRange(
      {DateTime? startDate, DateTime? endDate, DateTime? selectedDate}) {
    final currentDate = selectedDate;

    if (DateTime(currentDate!.year, currentDate.month, currentDate.day,
                    currentDate.hour, currentDate.minute, currentDate.second)
                .isAfter(DateTime(
                    startDate!.year,
                    startDate.month,
                    startDate.day,
                    startDate.hour,
                    startDate.minute,
                    startDate.second)) &&
            currentDate.isBefore(DateTime(endDate!.year, endDate.month,
                endDate.day, endDate.hour, endDate.minute, endDate.second)) ||
        startDate == selectedDate ||
        endDate == selectedDate) {
      return true;
    } else {
      return false;
    }
  }

  static bool isRangeWithinRange(
      String workStart, String workEnd, String breakStart, String breakEnd) {
    DateTime start1 = DateTime.parse(workStart);
    DateTime end1 = DateTime.parse(workEnd);
    DateTime start2 = DateTime.parse(breakStart);
    DateTime end2 = DateTime.parse(breakEnd);

    log("range check ======> ${DateTime(start1.year, start1.month, start1.day, start1.hour, start1.minute, start1.second).isAfter(DateTime(start2.year, start2.month, start2.day, start2.hour, start2.minute, start2.second)) && DateTime(end1.year, end1.month, end1.day, end1.hour, end1.minute, end1.second).isBefore(DateTime(end2.year, end2.month, end2.day, end2.hour, end2.minute, end2.second))}");
    log("start1 check ======> $start1}");
    log("end1 check ======> $end1}");
    log("start2 check ======> $start2}");
    log("end2 check ======> $end2}");

    return DateTime(start1.year, start1.month, start1.day, start1.hour,
                start1.minute, start1.second)
            .isAfter(DateTime(start2.year, start2.month, start2.day,
                start2.hour, start2.minute, start2.second)) &&
        DateTime(end1.year, end1.month, end1.day, end1.hour, end1.minute,
                end1.second)
            .isBefore(DateTime(end2.year, end2.month, end2.day, end2.hour,
                end2.minute, end2.second));
  }

  static bool isOverlap(
      {DateTime? start1, DateTime? end1, DateTime? start2, DateTime? end2}) {
    if (!(DateTime(end1!.year, end1.month, end1.day, end1.hour, end1.minute,
                    end1.second)
                .isBefore(DateTime(start2!.year, start2.month, start2.day,
                    start2.hour, start2.minute, start2.second)) ||
            DateTime(start1!.year, start1.month, start1.day, start1.hour,
                    start1.minute, start1.second)
                .isAfter(DateTime(end2!.year, end2.month, end2.day, end2.hour,
                    end2.minute, end2.second))) ||
        start1 == start2 ||
        end1 == end2) {
      return true;
    } else {
      return false;
    }
  }

  static DateTime recentSunday(DateTime dateTime) {
    DateTime mostRecentSunday = DateTime(
        dateTime.year, dateTime.month, dateTime.day - dateTime.weekday % 7);

    return mostRecentSunday;

    // something like 2013-04-20
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static DateTime getNextDate(DateTime dateTime) {
    final tomorrow = DateTime(dateTime.year, dateTime.month, dateTime.day + 1);
    log("next day : $tomorrow");

    return tomorrow;
  }

  static DateTime getWeekLastDay(DateTime dateTime) {
    int daysOfWeek = dateTime.weekday - 1;
    DateTime firstDay =
        DateTime(dateTime.year, dateTime.month, dateTime.day - daysOfWeek);
    DateTime lastDay =
        firstDay.add(const Duration(days: 6, hours: 23, minutes: 59));

    log(firstDay.toString());
    log(lastDay.toString());

    DateTime nextFirst = firstDay.add(const Duration(days: 7));
    DateTime nextLast = lastDay.add(const Duration(days: 7));

    log(nextFirst.toString());
    log(nextLast.toString());

    DateTime prevFirst = firstDay.subtract(const Duration(days: 7));
    DateTime prevLast = lastDay.subtract(const Duration(days: 7));

    log(prevFirst.toString());
    log(prevLast.toString());

    return lastDay;
  }

  static DateTime findNextMonday(DateTime todayDate) {
    DateTime? startDate;

    if (todayDate.weekday == 1) {
      startDate = DateTime.now();
    } else if (todayDate.add(const Duration(days: 1)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 1));
    } else if (todayDate.add(const Duration(days: 2)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 2));
    } else if (todayDate.add(const Duration(days: 3)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 3));
    } else if (todayDate.add(const Duration(days: 4)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 4));
    } else if (todayDate.add(const Duration(days: 5)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 5));
    } else if (todayDate.add(const Duration(days: 6)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 6));
    } else if (todayDate.add(const Duration(days: 7)).weekday == 1) {
      startDate = DateTime.now().add(const Duration(days: 7));
    }
    return (startDate!);
  }

  static String date(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    final DateFormat formatter =
        DateFormat('dd-MM-yyyy', AppContext.context.locale.languageCode);
    final String formatted = formatter.format(date);
    return formatted; // something like 20-2-2023
  }

  static String dateMonth(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    final DateFormat formatter =
        DateFormat('MMM.dd', AppContext.context.locale.languageCode);
    final String formatted = formatter.format(date);
    return formatted; // something like 2013-04-20
  }

  static String month(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    final DateFormat formatter =
        DateFormat('MMMM', AppContext.context.locale.languageCode);
    final String formatted = formatter.format(date);
    return formatted; // something like 2013-04-20
  }

  static String dateYear(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    final DateFormat formatter =
        DateFormat('MMMM yyyy', AppContext.context.locale.languageCode);
    final String formatted = formatter.format(date);
    return formatted; // something like 2013-04-20
  }

  static String utcTimeV(String dateTime) {
    return DateFormat("yyyy-MM-dd", AppContext.context.locale.languageCode)
        .format(DateTime.parse(dateTime).toUtc());
    // something like 2013-04-20
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    final givenDate = this;

    return now.day == givenDate.day &&
        now.month == givenDate.month &&
        now.year == givenDate.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}

extension DateTimeExtension on DateTime? {
  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return false;
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return false;
  }

  bool isBetween(DateTime startDate, DateTime endDate) {
    final isAfter = isAfterOrEqualTo(startDate);
    final isBefore = isBeforeOrEqualTo(endDate);
    return isAfter && isBefore;
  }
}
