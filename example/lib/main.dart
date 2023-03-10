import 'package:fhc_calendar/fhc_calendar_list.dart';
import 'package:fhc_calendar/fhc_calendar_widget.dart';
import 'package:fhc_calendar/widget/calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'package:fhc_calendar/widget/week_day_title.dart';

import 'gen/assets.gen.dart';

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
          title: const Text('FHC Calendar Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: FhcCalendarWidget(dateTime: DateTime.now(),),
              ),
              const SizedBox(
                height: 20,
              ),
              FhcCalendarList(
                fhcCalendarArg: FhcCalendarArg(
                    tickWidget: Container(
                      margin: const EdgeInsets.only(top: 10, left: 4),
                      child: Assets.tick.svg(width: 10, height: 10),
                    ),
                    lsMonth: [
                      MonthObject(
                        month: 'January',
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
                        month: 'February',
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
                        month: 'March',
                        lsCalendarStatus: List.generate(31, (index) {
                          return CalendarStatus(
                            tick: (index == 1 || index == 2) ? true : false,
                          );
                        }),
                      ),
                      MonthObject(
                        month: 'April',
                        lsCalendarStatus: List.generate(31, (index) {
                          return CalendarStatus(
                            tick: (index == 6 || index == 7) ? true : false,
                          );
                        }),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CalendarView(
                    dateTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                    weekdayTitle: WeekDaysTitle(),
                    monthObject: MonthObject(
                      month: 'January',
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
                    fhcCalendarArg: FhcCalendarArg(
                      boxDecorationCalendarView: const BoxDecoration(),
                      containMonth: false,
                      tickWidget: Container(
                          margin: const EdgeInsets.only(top: 10, left: 22),
                          child: Assets.tick.svg(width: 10, height: 10)),
                    )),
              ),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
