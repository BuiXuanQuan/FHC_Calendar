import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_state.dart';

class CalendarBloc extends Cubit<CalendarState> {
  CalendarBloc()
      : super(CalendarState(
          month: DateTime.now().month,
          year: DateTime.now().year,
          swipeIndex: 0,
        ));

  void initDateTime({
    required int month,
    required int year,
  }) {
    final newState = state.copyWith(month: month, year: year);
    emit(newState);
  }

  void selectedDate({DateTime? selectedDateTime}) {
    final newState = state.copyWith(selectedDateTime: selectedDateTime);
    emit(newState);
  }

  void changeSwipeIndex({
    required int swipeIndex,
  }) {
    final newState = state.copyWith(swipeIndex: swipeIndex);
    emit(newState);
  }

  void incrementMonth({
    required int currentMonth,
    required int currentYear,
  }) {
    if (currentMonth == 12) {
      final newState = state.copyWith(month: 1);
      emit(newState);
      incrementYear(currentYear: currentYear);
    } else {
      final month = currentMonth + 1;
      final newState = state.copyWith(month: month);
      emit(newState);
    }
    selectedDate(selectedDateTime: null);
  }

  void decrementMonth({
    required int currentMonth,
    required int currentYear,
  }) {
    if (currentMonth == 1) {
      final newState = state.copyWith(month: 12);
      emit(newState);
      decrementYear(currentYear: currentYear);
    } else {
      final month = currentMonth - 1;
      final newState = state.copyWith(month: month);
      emit(newState);
    }
    selectedDate(selectedDateTime: null);
  }

  void incrementYear({required int currentYear}) {
    final year = currentYear + 1;
    final newState = state.copyWith(year: year);
    emit(newState);
    selectedDate(selectedDateTime: null);
  }

  void decrementYear({required int currentYear}) {
    final year = currentYear - 1;
    final newState = state.copyWith(year: year);
    emit(newState);
    selectedDate(selectedDateTime: null);
  }

  static int calculateMonthsDifference(DateTime startDate, DateTime endDate) {
    final int yearsDifference = endDate.year - startDate.year;
    return 12 * yearsDifference + endDate.month - startDate.month;
  }
}
