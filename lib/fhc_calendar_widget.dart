import 'dart:developer';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:fhc_calendar/widget/back_next_widget/go_back_widget.dart';
import 'package:fhc_calendar/widget/back_next_widget/next_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fhc_calendar/bloc/calendar_bloc.dart';
import 'package:fhc_calendar/bloc/calendar_state.dart';
import 'package:fhc_calendar/widget/week_day_title.dart';

import 'fhc_calendar_list.dart';
import 'widget/calendar/calendar.dart';

class FhcCalendarWidget extends StatefulWidget {
  const FhcCalendarWidget({
    Key? key,
    this.onTap,
    this.textStyle,
    this.selectedTextStyle = const TextStyle(color: Colors.white),
    this.paddingOfItemDay,
    this.marginOfItemDay,
    this.selectedBoxDecorationOfItemDay,
    this.boxDecorationOfItemDay,
    this.startDate,
    this.endDate,
    this.physics = const NeverScrollableScrollPhysics(),
    this.dateTime,
    this.setTimeWidget,
    this.year = 'Year',
    this.month = "Month",
    this.spaceBetweenSetTimeAndCalendar = 20,
    this.monthYearWidgetHanlder,
    this.weekdaysHandler,
    this.weekdaysWidget,
  }) : super(key: key);
  final ValueChanged<DateTime>? onTap;
  final TextStyle? textStyle;
  final TextStyle selectedTextStyle;
  final EdgeInsetsGeometry? paddingOfItemDay;
  final EdgeInsetsGeometry? marginOfItemDay;
  final BoxDecoration? selectedBoxDecorationOfItemDay;
  final BoxDecoration? boxDecorationOfItemDay;
  final DateTime? dateTime;
  final DateTime? startDate;
  final String year;
  final String month;
  final DateTime? endDate;
  final ScrollPhysics physics;
  final Widget? setTimeWidget;
  final Widget? weekdaysWidget;
  final double spaceBetweenSetTimeAndCalendar;
  final MonthYearWidgetHanlder? monthYearWidgetHanlder;
  final WeekdaysHandler? weekdaysHandler;
  @override
  State<FhcCalendarWidget> createState() => _FhcCalendarWidgetState();
}

class _FhcCalendarWidgetState extends State<FhcCalendarWidget> {
  int lengthPageView = 1;
  MonthYearWidgetHanlder? get _monthYearWidgetHanlder =>
      widget.monthYearWidgetHanlder;

  @override
  void initState() {
    super.initState();
    if (widget.physics != const NeverScrollableScrollPhysics()) {
      lengthPageView = CalendarBloc.calculateMonthsDifference(
          widget.startDate ?? DateTime(2000), widget.endDate ?? DateTime(2100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        if (widget.startDate != null) {
          return CalendarBloc()
            ..initDateTime(
                year: widget.startDate!.year, month: widget.startDate!.month);
        }
        return CalendarBloc();
      },
      child: Center(
        child: Column(
          children: [
            widget.setTimeWidget ?? _setTimeWidget(),
            SizedBox(
              height: widget.spaceBetweenSetTimeAndCalendar,
            ),
            BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
              return ExpandablePageView(
                physics: widget.physics,
                onPageChanged: (index) {
                  if (index > state.swipeIndex) {
                    context.read<CalendarBloc>().incrementMonth(
                        currentMonth: state.month, currentYear: state.year);
                  } else {
                    context.read<CalendarBloc>().decrementMonth(
                        currentMonth: state.month, currentYear: state.year);
                  }

                  context
                      .read<CalendarBloc>()
                      .changeSwipeIndex(swipeIndex: index);
                },
                children: List.generate(lengthPageView, (index) {
                  return BlocBuilder<CalendarBloc, CalendarState>(
                      builder: (context, state) {
                    return Calendar(
                      selectedBoxDecorationOfItemDay:
                          widget.selectedBoxDecorationOfItemDay,
                      boxDecorationOfItemDay: widget.boxDecorationOfItemDay,
                      selectedTextStyle: widget.selectedTextStyle,
                      textStyle: widget.textStyle,
                      paddingOfItemDay: widget.paddingOfItemDay,
                      marginOfItemDay: widget.marginOfItemDay,
                      selectedDay: state.selectedDateTime?.day,
                      dateTime: widget.dateTime ??
                          DateTime(state.year, state.month, 1),
                      weekdayTitle: widget.weekdaysWidget ??
                          WeekDaysTitle(
                            weekdaysHandler: widget.weekdaysHandler,
                          ),
                      onTap: (dateTime) {
                        if (dateTime.day == state.selectedDateTime?.day) {
                          context
                              .read<CalendarBloc>()
                              .selectedDate(selectedDateTime: null);
                        } else {
                          context
                              .read<CalendarBloc>()
                              .selectedDate(selectedDateTime: dateTime);
                        }
                        widget.onTap?.call(dateTime);
                      },
                    );
                  });
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _setTimeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GoBackWidget(
                goBackWidget: _monthYearWidgetHanlder?.goBackForYear,
                onGoBack: () {
                  context
                      .read<CalendarBloc>()
                      .decrementYear(currentYear: state.year);
                },
              ),
              Text(
                '${widget.year} ${state.year}',
                style: _monthYearWidgetHanlder?.yearTextStyle,
              ),
              NextWidget(
                nextWidget: _monthYearWidgetHanlder?.nextForYear,
                onNext: () {
                  context
                      .read<CalendarBloc>()
                      .incrementYear(currentYear: state.year);
                },
              ),
            ],
          );
        }),
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GoBackWidget(
                goBackWidget: _monthYearWidgetHanlder?.goBackForMonth,
                onGoBack: () {
                  context.read<CalendarBloc>().decrementMonth(
                      currentMonth: state.month, currentYear: state.year);
                },
              ),
              Text(
                '${widget.month} ${state.month}',
                style: _monthYearWidgetHanlder?.monthTextStyle,
              ),
              NextWidget(
                nextWidget: _monthYearWidgetHanlder?.nextForMonth,
                onNext: () {
                  context.read<CalendarBloc>().incrementMonth(
                      currentMonth: state.month, currentYear: state.year);
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}

class MonthYearWidgetHanlder {
  final Widget? goBackForYear;
  final Widget? goBackForMonth;
  final Widget? nextForYear;
  final Widget? nextForMonth;
  final TextStyle? monthTextStyle;
  final TextStyle? yearTextStyle;

  MonthYearWidgetHanlder({
    this.monthTextStyle,
    this.yearTextStyle,
    this.goBackForYear,
    this.goBackForMonth,
    this.nextForYear,
    this.nextForMonth,
  });
}

class WeekdaysHandler {
  final TextStyle? weekDaysTitleTextStyle;
  final List<String>? lsWeekDays;
  WeekdaysHandler({
    this.weekDaysTitleTextStyle,
    this.lsWeekDays,
  });
}
