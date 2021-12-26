import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'todo_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    final Database _database = await database();
    await _database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Future<List<Task>> getTasks() async {
  //   final Database _database = await database();
  //   List<Map<String, dynamic?>>? taskMap = await _database.query('tasks');
  //   return List.generate(taskMap.length, (index) => Task(id: taskMap[index]['id']));
  // }

  Future<List<Task>> getTasks() async {
    final Database _database = await database();
    final List<Map<String, dynamic>> maps = await _database.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title']?.toString(),
        description: maps[index]['description']?.toString(),
      );
    });
  }
}
