import 'package:flutter/material.dart';

import 'calendar_view_item.dart';

typedef BuildItemCalendar<T> = Widget Function(
    BuildContext context, DateTime date);

// ignore: must_be_immutable
class CalendarMothView extends StatelessWidget {
  CalendarMothView(
      {super.key,
      required this.dateTime,
      required this.weekdayTitle,
      required this.itemCalendarBuilder});

  final DateTime dateTime;
  final Widget weekdayTitle;
  final BuildItemCalendar itemCalendarBuilder;

  int? dayUpdate;
  int dayForFirstRow = 0;
  DateTime myDateAfterPlus =
      DateTime.now().subtract(Duration(days: DateTime.now().daysInMonth()));
  final maxRowsNumber = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ..._buildListOfRow(context),
      ],
    );
  }

  List<Widget> _buildListOfRow(
    BuildContext context,
  ) {
    var firstWeekday = dateTime.copyWith(day: 1).weekday;
    final List<Widget> rows = <Widget>[];
    rows.add(weekdayTitle);

    rows.add(
      _buildFirstRow(
          weekday: firstWeekday, dateTimeDefault: dateTime, context: context),
    );

    DateTime date = DateTime(dateTime.year, dateTime.month, dayForFirstRow + 1);

    for (var i = 0; i < maxRowsNumber; i++) {
      if (dayUpdate != null) {
        date = DateTime(dateTime.year, dateTime.month, dayUpdate!);
      }
      // if (myDateAfterPlus.month <= date.month && myDateAfterPlus.day != 1) {
        rows.add(_buildRow(
          dateTimeDefault: date,
          context: context,
        ));
      // }
    }

    return rows;
  }

  Row _buildRow({
    required DateTime dateTimeDefault,
    required BuildContext context,
  }) {
    List<Widget> widget = [];
    myDateAfterPlus = dateTimeDefault;

    for (int i = 0; i < 7; i++) {
      // checking when month is 12
      if (myDateAfterPlus.day == 1) {
        widget.add(CalendarViewItem());
        continue;
      }
      if (myDateAfterPlus.month > dateTimeDefault.month) {
        widget.add(CalendarViewItem());
      } else {
        widget.add(itemCalendarBuilder.call(context, myDateAfterPlus));
      }

      myDateAfterPlus = myDateAfterPlus.add(const Duration(days: 1));
    }

    dayUpdate = myDateAfterPlus.day;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget,
    );
  }

  Widget _buildFirstRow(
      {int weekday = 0,
      required DateTime dateTimeDefault,
      required BuildContext context}) {
    List<Widget> widget = [];
    int day = 0;
    for (int i = 0; i < 7; i++) {
      if ((weekday - 1) <= i) {
        final dividedNumber = i - weekday;
        day = dividedNumber + 2;
        final date = DateTime(dateTimeDefault.year, dateTimeDefault.month, day);
        widget.add(itemCalendarBuilder.call(context, date));
      } else {
        widget.add(CalendarViewItem());
      }
    }
    dayForFirstRow = day;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget,
    );
  }
}

extension CustomDateTime on DateTime {
  int daysInMonth() {
    if (month > 12) {
      return 1;
    }
    final List<int> monthLength = List.filled(12, 0);
    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[month - 1];
  }

  bool leapYear(int year) {
    bool leapYear = false;
    final bool leap = (year % 100 == 0) && (year % 400 != 0);
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
