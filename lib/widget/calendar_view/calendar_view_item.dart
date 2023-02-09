import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:fhc_calendar/fhc_calendar_list.dart';

class CalendarViewItem extends StatelessWidget {
  CalendarViewItem({
    Key? key,
    this.date,
    this.fhcCalendarArg,
    this.lsCalendarStatus,
    this.isFirstRow = false,
  }) : super(key: key);
  final DateTime? date;
  CalendarStatus? calendarStatus;
  final FhcCalendarArg? fhcCalendarArg;
  final List<CalendarStatus>? lsCalendarStatus;
  late int index;
  final bool isFirstRow;

  @override
  Widget build(BuildContext context) {
    if (date != null) {
      index = date!.day - 1;
      calendarStatus = lsCalendarStatus?[index];
    }
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: fhcCalendarArg?.paddingOfItemDay,
            margin: fhcCalendarArg?.marginOfItemDay ??
                const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            decoration: calendarStatus?.tick == true
                ? fhcCalendarArg?.tickBoxDecorationOfItemDay
                // .copyWith(color: const Color(0xFFE4D6B8).withOpacity(0.5))
                : calendarStatus?.chosen == true
                    ? fhcCalendarArg?.chosenBoxDecorationOfItemDay
                    : (fhcCalendarArg?.boxDecorationOfItemDay ??
                        const BoxDecoration()),
            child: Text(
              date != null ? date!.day.toString() : '',
              textAlign: TextAlign.center,
              style: calendarStatus?.tick == true
                  ? fhcCalendarArg?.tickTextStyle
                  // .copyWith(color: const Color(0xFF263238).withOpacity(0.5))
                  : calendarStatus?.chosen == true
                      ? fhcCalendarArg?.chosenTextStyle
                      : fhcCalendarArg?.textStyle,
            ),
          ),
          if (calendarStatus?.tick == true)
            Align(
              alignment: Alignment.center,
              child: fhcCalendarArg!.tickWidget,
            )
        ],
      ),
    );
  }
}
