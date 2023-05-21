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
    // TODO: Implement
    debugPrint("TodoRepositoryIsar.getTodos()");
    return [];
  }

  Future<TodoIsar?> getTodo(int id) async {
    // TODO: Implement
    debugPrint("TodoRepositoryIsar.getTodo($id)");
    return null;
  }

  Future addTodo(TodoIsar todo) async {
    // TODO: Implement
    debugPrint("TodoRepositoryIsar.addTodo($todo)");
  }

  Future deleteTodo(int id) async {
    // TODO: Implement
    debugPrint("TodoRepositoryIsar.deleteTodo($id)");
  }

  Future updateTodo(TodoIsar todo) async {
    // TODO: Implement
    debugPrint("TodoRepositoryIsar.updateTodo($todo)");
  }
}
