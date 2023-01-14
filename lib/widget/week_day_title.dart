import 'package:fhc_calendar/fhc_calendar_widget.dart';
import 'package:flutter/material.dart';

import '../fhc_calendar.dart';

class WeekDaysTitle extends StatelessWidget {
  WeekDaysTitle({
    super.key,
    this.weekdaysHandler,
  });
  final _lsWeekDay = <String>['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  final WeekdaysHandler? weekdaysHandler;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        weekdaysHandler?.lsWeekDays?.length ?? _lsWeekDay.length,
        (index) => Expanded(
          child: Text(
            _lsWeekDay[index],
            textAlign: TextAlign.center,
            style: weekdaysHandler?.weekDaysTitleTextStyle ??
                const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
