import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum CounterUnits { summary, years, months, weeks, days, hours, minutes }

class Event {
  Event({
    String? id,
    required this.title,
    required this.date,
    required this.isAllDay,
    required this.hmsTime,
    this.timeUnit = CounterUnits.summary,
    this.isCountdown = false,
    this.isDone = false,
    this.color = Colors.black,
    required this.icon,
    // this.startDate = DateTime.now(),
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final bool isAllDay;
  final DateTime hmsTime;
  final CounterUnits timeUnit;
  final bool isCountdown;
  final bool isDone;
  final Color color;
  final Icon icon;
  // final DateTime startDate;
}
