import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'packag';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'events.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_events(id TEXT PRIMARY KEY, title TEXT, date BLOB, isAllDay INTEGER, hmsTime BLOB, timeUnit TEXT, isCountdown INTEGER, isDone INTEGER, color BLOB, icon BLOB)');
    },
  );

  return db;
}


class UserEventsNotifier extends StateNotifier<> {
  UserEventsNotifier(): super();
  
  Future<void> loadEvents() async{
    final db = await _getDatabase();
    final data = await db.query('user_events')
  }
}