import 'package:fhc_calendar/fhc_calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:fhc_calendar/widget/calendar/calendar.dart';
import 'package:fhc_calendar/widget/calendar_view/calendar_view.dart';
import 'package:fhc_calendar/widget/week_day_title.dart';

import 'fhc_calendar.dart';

class FhcCalendarList extends StatefulWidget {
  const FhcCalendarList({
    Key? key,
    required this.fhcCalendarArg,
  }) : super(key: key);
  final FhcCalendarArg fhcCalendarArg;

  @override
  State<FhcCalendarList> createState() => _FhcCalendarListState();
}

class _FhcCalendarListState extends State<FhcCalendarList> {
  FhcCalendarArg get _fhcCalendarArg => widget.fhcCalendarArg;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        physics: _fhcCalendarArg.physics,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: LayoutBuilder(builder: (context, constraints) {
            return Wrap(
              spacing: _fhcCalendarArg.spacing,
              runSpacing: _fhcCalendarArg.runSpacing,
              children: List.generate(_fhcCalendarArg.lsMonth.length, (index) {
                final item = _fhcCalendarArg.lsMonth[index];

                return Container(
                  constraints:
                      BoxConstraints(minHeight: _fhcCalendarArg.height ?? 215),
                  width:
                      constraints.maxWidth / 2 - (_fhcCalendarArg.spacing / 2),
                  child: CalendarView(
                    dateTime: DateTime(
                      _fhcCalendarArg.year ?? DateTime.now().year,
                      index + 1,
                      1,
                    ),
                    weekdayTitle: _fhcCalendarArg.weekdaysWidget ??
                        WeekDaysTitle(
                          weekdaysHandler: _fhcCalendarArg.weekdaysHandler,
                        ),
                    monthObject: item,
                    fhcCalendarArg: _fhcCalendarArg,
                  ),
                );
              }),
            );
          }),
        ),
      
    );
  }
}

class FhcCalendarArg {
  final Widget? weekdaysWidget;
  final Widget tickWidget;
  final double width;
  final double spacing;
  final double runSpacing;
  final bool containMonth;
  final int? year;
  final double? height;
  final List<MonthObject> lsMonth;
  final TextStyle? monthTextStyle;
  final ScrollPhysics? physics;
  final BoxDecoration? boxDecorationCalendarView;
  final double? spaceBetweenMonthAndCalendar;
  final TextStyle? textStyle;
  final TextStyle chosenTextStyle;
  final TextStyle tickTextStyle;
  final WeekdaysHandler? weekdaysHandler;
  final EdgeInsetsGeometry paddingOfItemDay;
  final EdgeInsetsGeometry? marginOfItemDay;
  final BoxDecoration chosenBoxDecorationOfItemDay;
  final BoxDecoration tickBoxDecorationOfItemDay;

  final BoxDecoration? boxDecorationOfItemDay;
  FhcCalendarArg( {
    this.containMonth = true,
    this.weekdaysHandler,
  required  this.tickWidget,
    this.tickTextStyle = const TextStyle(color: Colors.black, fontSize: 10),
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 10),
    this.chosenTextStyle = const TextStyle(color: Colors.black, fontSize: 10),
    this.paddingOfItemDay = const EdgeInsets.all(4),
    this.marginOfItemDay = const EdgeInsets.symmetric(vertical: 4),
    this.tickBoxDecorationOfItemDay = const BoxDecoration(
      color: Color(0xFFE4D6B8),
      shape: BoxShape.circle,
    ),
    this.chosenBoxDecorationOfItemDay = const BoxDecoration(
      color: Color(0xFFE4D6B8),
      shape: BoxShape.circle,
    ),
    this.boxDecorationOfItemDay,
    this.weekdaysWidget,
    this.width = 163,
    this.spacing = 22,
    this.runSpacing = 12,
    this.year,
    this.height,
     this.lsMonth = const [],
    this.monthTextStyle,
    this.physics,
    this.boxDecorationCalendarView,
    this.spaceBetweenMonthAndCalendar,
  });
}

class MonthObject {
  final String month;
  final List<CalendarStatus> lsCalendarStatus;

  MonthObject({
    this.month = '',
    required this.lsCalendarStatus,
  });
}

class CalendarStatus {
  final bool tick;
  final bool chosen;

  CalendarStatus({
    this.tick = false,
    this.chosen = false,
  });
}
