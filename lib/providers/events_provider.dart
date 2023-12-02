import 'package:coucoucountdown/models/event.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'events.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_events(id TEXT PRIMARY KEY, title TEXT, eventDate BLOB, isAllDay INTEGER, hmsTime BLOB, timeUnit TEXT, isCountdown INTEGER, isDone INTEGER, color BLOB, icon BLOB)');
    },
  );

  return db;
}

class UserEventsNotifier extends StateNotifier<List<Event>> {
  UserEventsNotifier() : super([]);

  Future<void> loadEvents() async {
    final db = await _getDatabase();
    final data = await db.query('user_events');
    final events = data
        .map(
          (row) => Event(
              title: row['title'] as String,
              eventDate: row['eventDate'] as DateTime,
              isAllDay: row['isAllDay'] as bool,
              hmsTime: row['hmsTime'] as DateTime,
              timeUnit: row['timeUnit'] as CounterUnits,
              isCountdown: row['isCountdown'] as bool,
              isDone: row['isDone'] as bool,
              color: row['color'] as Color,
              icon: row['icon'] as Icon),
        )
        .toList();

    state = events;
  }

  void addEvent(Event newEvent) async {
    final db = await _getDatabase();
    db.insert(
      'user_events',
      {
        'id': newEvent.id,
        'title': newEvent.title,
        'eventDate': newEvent.eventDate,
        'isAllDay': newEvent.isAllDay,
        'hmsTime': newEvent.hmsTime,
        'timeUnit': newEvent.timeUnit,
        'isCountdown': newEvent.isCountdown,
        'isDone': newEvent.isDone,
        'color': newEvent.color,
        'icon': newEvent.icon,
      },
    );

    state = [newEvent, ...state];
  }
}
