import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class TaskDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    if (_database != null) return _database!;
    return _database = await _initDB();
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT
        )
      ''');
        await db.execute('''
        CREATE TABLE task_status (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          task_id INTEGER,
          date TEXT,
          done INTEGER,
          FOREIGN KEY (task_id) REFERENCES tasks (id)
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE task_status (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task_id INTEGER,
            date TEXT,
            done INTEGER,
            FOREIGN KEY (task_id) REFERENCES tasks (id)
          )
        ''');
        }
      },
    );
  }

  static Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  static Future<List<Task>> getTasks() async {
    final db = await database;
    final maps = await db.query('tasks');
    return maps.map((e) => Task.fromMap(e)).toList();
  }

  static Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<bool> isTaskDoneToday(int taskId) async {
    final db = await database;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final res = await db.query(
      'task_status',
      where: 'task_id = ? AND date = ?',
      whereArgs: [taskId, today],
    );
    if (res.isEmpty) return false;
    return res.first['done'] == 1;
  }

  static Future<void> setTaskDone(int taskId, bool done) async {
    final db = await database;
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final existing = await db.query(
      'task_status',
      where: 'task_id = ? AND date = ?',
      whereArgs: [taskId, today],
    );

    final data = {'task_id': taskId, 'date': today, 'done': done ? 1 : 0};

    if (existing.isEmpty) {
      await db.insert('task_status', data);
    } else {
      await db.update(
        'task_status',
        data,
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    }
  }
}
