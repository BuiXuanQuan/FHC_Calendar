import 'dart:developer';
import 'package:fhc_calendar/widget/calendar/calendar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Calendar extends StatelessWidget {
  Calendar({
    super.key,
    required this.weekdayTitle,
    this.onTap,
    required this.dateTime,
    required this.selectedDay,
    this.textStyle,
    this.selectedTextStyle = const TextStyle(color: Colors.white),
    this.paddingOfItemDay,
    this.marginOfItemDay,
    this.selectedBoxDecorationOfItemDay,
    this.boxDecorationOfItemDay,
  });
  final int? selectedDay;

  final DateTime dateTime;
  final Widget weekdayTitle;
  final ValueChanged<DateTime>? onTap;
  final TextStyle? textStyle;
  final TextStyle selectedTextStyle;
  final EdgeInsetsGeometry? paddingOfItemDay;
  final EdgeInsetsGeometry? marginOfItemDay;
  final BoxDecoration? selectedBoxDecorationOfItemDay;
  final BoxDecoration? boxDecorationOfItemDay;
  int? dayUpdate;
  int dayForFirstRow = 0;
  DateTime myDateAfterPlus = DateTime.now().subtract(const Duration(days: 30));
  final maxRowsNumber = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildListOfRow(context),
    );
  }

  List<Widget> _buildListOfRow(
    BuildContext context,
  ) {
    // log('day time :${dateTime}');
    var firstWeekday = dateTime.weekday;
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
        widget.add(const CalendarItem());
        continue;
      }
      if (myDateAfterPlus.month > dateTimeDefault.month) {
        widget.add(const CalendarItem());
      } else {
        widget.add(CalendarItem(
          date: myDateAfterPlus,
          isSelected: selectedDay == myDateAfterPlus.day,
          onTap: onTap,
          selectedBoxDecorationOfItemDay: selectedBoxDecorationOfItemDay,
          boxDecorationOfItemDay: boxDecorationOfItemDay,
          selectedTextStyle: selectedTextStyle,
          textStyle: textStyle,
          paddingOfItemDay: paddingOfItemDay,
          marginOfItemDay: marginOfItemDay,
        ));
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
    log('dateTimeDefault: ${dateTimeDefault}');
    List<Widget> widget = [];
    int day = 0;
    for (int i = 0; i < 7; i++) {
      if ((weekday - 1) <= i) {
        final dividedNumber = i - weekday;
        day = dividedNumber + 2;
        widget.add(CalendarItem(
          isSelected: selectedDay == day,
          date: DateTime(dateTimeDefault.year, dateTimeDefault.month, day),
          onTap: onTap,
          selectedBoxDecorationOfItemDay: selectedBoxDecorationOfItemDay,
          boxDecorationOfItemDay: boxDecorationOfItemDay,
          selectedTextStyle: selectedTextStyle,
          textStyle: textStyle,
          paddingOfItemDay: paddingOfItemDay,
          marginOfItemDay: marginOfItemDay,
        ));
      } else {
        widget.add(const CalendarItem());
      }
    }
    dayForFirstRow = day;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget,
    );
  }
}
