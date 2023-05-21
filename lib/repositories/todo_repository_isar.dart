import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_practice/models/todo_isar.dart';
import 'package:path_provider/path_provider.dart';

class TodoRepositoryIsar {
  late final Isar isar;

  Future initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoIsarSchema],
      directory: dir.path,
    );
    debugPrint("TodoRepositoryIsar.initIsar()");

    // TODO: Prepare initial data
  }

  Future<List<TodoIsar>> getTodos() async {
    debugPrint("TodoRepositoryIsar.getTodos()");
    return await isar.todoIsars.where().findAll();
  }

  Future<TodoIsar?> getTodo(int id) async {
    debugPrint("TodoRepositoryIsar.getTodo($id)");
    return await isar.todoIsars.get(id);
  }

  Future addTodo(TodoIsar todo) async {
    debugPrint("TodoRepositoryIsar.addTodo($todo)");
    await isar.writeTxn(() async {
      Id id = await isar.todoIsars.put(todo);
      debugPrint("TodoRepositoryIsar.addTodo(). id: $id");
    });
  }

  Future deleteTodo(int id) async {
    debugPrint("TodoRepositoryIsar.deleteTodo($id)");
    await isar.writeTxn(() async {
      await isar.todoIsars.delete(id);
    });
  }

  Future updateTodo(TodoIsar todo) async {
    debugPrint("TodoRepositoryIsar.updateTodo($todo)");
    await isar.writeTxn(() async {
      Id id = await isar.todoIsars.put(todo);
      debugPrint("TodoRepositoryIsar.updateTodo(). id: $id");
    });
  }
}
