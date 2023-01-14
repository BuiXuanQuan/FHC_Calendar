import 'dart:developer';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:fhc_calendar/fhc_calendar_list.dart';
import 'package:fhc_calendar/fhc_calendar_widget.dart';
import 'package:fhc_calendar/widget/back_next_widget/go_back_widget.dart';
import 'package:fhc_calendar/widget/back_next_widget/next_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fhc_calendar/bloc/calendar_bloc.dart';
import 'package:fhc_calendar/bloc/calendar_state.dart';
import 'package:fhc_calendar/widget/week_day_title.dart';

import 'gen/assets.gen.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FHC Calendar',
      home: Scaffold(
        appBar: AppBar(
          title: Text('FHC Calendar Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const FhcCalendarWidget(),
              const SizedBox(
                height: 20,
              ),
              FhcCalendarList(
                fhcCalendarArg: FhcCalendarArg(
                    tickWidget: Container(
                        margin: const EdgeInsets.only(top: 10, left: 4),
                        child: Assets.tick.svg(width: 10, height: 10)),
                    lsMonth: [
                      MonthObject(
                        month: 'Tháng 1',
                        lsCalendarStatus: List.generate(31, (index) {
                          return CalendarStatus(
                            chosen: index == 4 || index == 5 ? true : false,
                            tick: index == 0 ||
                                    index == 1 ||
                                    index == 2 ||
                                    index == 3
                                ? true
                                : false,
                          );
                        }),
                      ),
                      MonthObject(
                        month: 'Tháng 2',
                        lsCalendarStatus: List.generate(
                          31,
                          (index) {
                            return CalendarStatus(
                              chosen: (index == 4 ||
                                      index == 3 ||
                                      index == 0 ||
                                      index == 27 ||
                                      index == 26)
                                  ? true
                                  : false,
                              tick: (index == 27 || index == 26) ? true : false,
                            );
                          },
                        ),
                      ),
                      MonthObject(
                        month: 'Tháng 3',
                        lsCalendarStatus: List.generate(31, (index) {
                          return CalendarStatus(
                            tick: (index == 1 || index == 2) ? true : false,
                          );
                        }),
                      ),
                      MonthObject(
                        month: 'Tháng 4',
                        lsCalendarStatus: List.generate(31, (index) {
                          return CalendarStatus(
                            tick: (index == 6 || index == 7) ? true : false,
                          );
                        }),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
