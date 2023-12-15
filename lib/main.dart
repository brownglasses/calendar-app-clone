import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: TableCalendar(
          firstDay: DateTime(1900, 1, 1),
          focusedDay: DateTime.now(),
          lastDay: DateTime(2999, 12, 31),
          selectedDayPredicate: (DateTime day) {
            final now = DateTime.now();
            return DateTime(day.year, day.month, day.day)
                .isAtSameMomentAs(DateTime(now.year, now.month, now.day));
          },
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {},
          onPageChanged: (DateTime focusedDay) {},
          rangeSelectionMode: RangeSelectionMode.toggledOff,
          onRangeSelected:
              (DateTime? start, DateTime? end, DateTime focusedDay) {},
        ),
      ),
    ),
  );
}
