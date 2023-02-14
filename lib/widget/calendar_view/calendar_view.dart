import 'dart:math';

import 'package:fhc_calendar/fhc_calendar_list.dart';
import 'package:flutter/material.dart';

import 'calendar_view_item.dart';

// ignore: must_be_immutable
class CalendarView extends StatelessWidget {
  CalendarView({
    super.key,
    required this.fhcCalendarArg,
    required this.monthObject,
    required this.dateTime,
    required this.weekdayTitle,
  });

  final MonthObject monthObject;
  final DateTime dateTime;
  final Widget weekdayTitle;
  final FhcCalendarArg fhcCalendarArg;

  int? dayUpdate;
  int dayForFirstRow = 0;
  DateTime myDateAfterPlus = DateTime.now().subtract(const Duration(days: 31));
  final maxRowsNumber = 5;
  List<CalendarStatus> get _lsCalendarStatusUpdate =>
      monthObject.lsCalendarStatus;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      decoration: fhcCalendarArg.boxDecorationCalendarView ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (fhcCalendarArg.containMonth) ...[
            Text(
              monthObject.month,
              style: fhcCalendarArg.monthTextStyle,
            ),
            SizedBox(
              height: fhcCalendarArg.spaceBetweenMonthAndCalendar ?? 4,
            ),
          ],
          ..._buildListOfRow(context),
        ],
      ),
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
        weekday: firstWeekday,
        dateTimeDefault: dateTime,
      ),
    );

    DateTime date = DateTime(dateTime.year, dateTime.month, dayForFirstRow + 1);

    for (var i = 0; i < maxRowsNumber; i++) {
      if (dayUpdate != null) {
        date = DateTime(dateTime.year, dateTime.month, dayUpdate!);
      }
      if (myDateAfterPlus.month <= date.month && myDateAfterPlus.day != 1) {
        rows.add(_buildRow(
          dateTimeDefault: date,
          context: context,
        ));
      }
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
        widget.add(CalendarViewItem(
            lsCalendarStatus: _lsCalendarStatusUpdate,
            date: myDateAfterPlus,
            fhcCalendarArg: fhcCalendarArg));
      }

      myDateAfterPlus = myDateAfterPlus.add(const Duration(days: 1));
    }

    dayUpdate = myDateAfterPlus.day;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget,
    );
  }

  Widget _buildFirstRow({
    int weekday = 0,
    required DateTime dateTimeDefault,
  }) {
    List<Widget> widget = [];
    int day = 0;
    for (int i = 0; i < 7; i++) {
      if ((weekday - 1) <= i) {
        final dividedNumber = i - weekday;
        day = dividedNumber + 2;
        final date = DateTime(dateTimeDefault.year, dateTimeDefault.month, day);
        widget.add(CalendarViewItem(
          isFirstRow: true,
          lsCalendarStatus: _lsCalendarStatusUpdate,
          date: date,
          fhcCalendarArg: fhcCalendarArg,
        ));
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
