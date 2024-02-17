import 'package:coucoucountdown/models/event.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'events.db'),
    version: 10,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_events(id TEXT PRIMARY KEY, title TEXT, eventDate BLOB, timeUnit BLOB, isCountdown BLOB, isDone BLOB, color INTEGER, icon BLOB)');
    },
  );

  return db;
}

class UserEventsNotifier extends StateNotifier<List<Event>> {
  UserEventsNotifier() : super([]);

  Future<void> loadEvents() async {
    final db = await _getDatabase();
    // await db.execute('DELETE FROM user_events;');
    final data = await db.query('user_events ORDER BY eventDate ASC');
    final events = data.map((e) => Event.fromMap(e)).toList();
    print(data.map((e) => Event.fromMap(e)).toList());
    state = events;
  }

  //add data to db
  void addEvent(Event newEvent) async {
    final db = await _getDatabase();
    db.insert('user_events', newEvent.toMap());
    loadEvents();
    print(' EVENT????????? ${newEvent.toMap()}');
    // state = [newEvent, ...state];
  }

  void deleteEvent(String eventID) async {
    final db = await _getDatabase();
    db.execute("DELETE FROM user_events WHERE id = '$eventID'");
    loadEvents();
  }

  void editEvent(Event event) async {
    final db = await _getDatabase();
    db.update(
        'user_events',
        {
          'title': event.title,
          'eventDate': event.eventDate,
          'timeUnit': event.timeUnit,
          'color': event.color,
          'icon': event.icon,
        },
        where: "id = '${event.id}'");
    // db.execute(
    //     "UPDATE user_events SET title = '${event.title}', eventDate = '${event.eventDate}', timeUnit = '${event.timeUnit}', color = '${event.color}', icon = '${event.icon}' WHERE id = '${event.id}'");
    loadEvents();
  }
}

final userEventsProvider =
    StateNotifierProvider<UserEventsNotifier, List<Event>>(
        (ref) => UserEventsNotifier());
