import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum CounterUnits { summary, years, months, weeks, days, hours, minutes }

class Event {
  Event({
    String? id,
    required this.title,
    required this.eventDate,
    required this.timeUnit,
    this.isCountdown = 0,
    this.isDone = 0,
    required this.color,
    required this.icon,
    // this.startDate = DateTime.now(),
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final String eventDate;
  final String timeUnit;
  final int isCountdown;
  final int isDone;
  final String color;
  final String icon;
  // final DateTime startDate;

  factory Event.fromMap(Map<String, dynamic> json) => Event(
      id: json['id'],
      title: json['title'],
      eventDate: json['eventDate'],
      timeUnit: json['timeUnit'],
      isCountdown: json['isCountdown'],
      isDone: json['isDone'],
      color: json['color'],
      icon: json['icon']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'eventDate': eventDate,
      'timeUnit': timeUnit,
      'isCountdown': isCountdown,
      'isDone': isDone,
      'color': color,
      'icon': icon,
    };
  }
}
