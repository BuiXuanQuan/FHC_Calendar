import 'dart:ui';

import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    Key? key,
    this.date,
    this.onTap,
    this.isSelected = false,
    this.textStyle,
    this.selectedTextStyle = const TextStyle(color: Colors.white),
    this.paddingOfItemDay,
    this.marginOfItemDay,
    this.selectedBoxDecorationOfItemDay,
    this.boxDecorationOfItemDay,
  }) : super(key: key);
  final DateTime? date;
  final bool isSelected;
  final ValueChanged<DateTime>? onTap;
  final TextStyle? textStyle;
  final TextStyle selectedTextStyle;
  final EdgeInsetsGeometry? paddingOfItemDay;
  final EdgeInsetsGeometry? marginOfItemDay;
  final BoxDecoration? selectedBoxDecorationOfItemDay;
  final BoxDecoration? boxDecorationOfItemDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap?.call(date ?? DateTime.now());
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: double.infinity,
          padding: paddingOfItemDay ?? const EdgeInsets.all(8),
          margin: marginOfItemDay ??
              const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          decoration: isSelected
              ? (selectedBoxDecorationOfItemDay ??
                  const BoxDecoration(
                    color: Color(0xFF137979),
                    shape: BoxShape.circle,
                  ))
              : (boxDecorationOfItemDay ?? const BoxDecoration()),
          child: Text(
            date != null ? date!.day.toString() : '',
            textAlign: TextAlign.center,
            style: isSelected
                ? selectedTextStyle.copyWith(color: Colors.white)
                : textStyle,
          ),
        ),
      ),
    );
  }
}
