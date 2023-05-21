import 'dart:async';

import 'package:flutter/material.dart';

import '../models/todo_isar.dart';
import '../repositories/todo_repository_isar.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<TodoIsar> todos = [];
  TodoRepositoryIsar todoRepository = TodoRepositoryIsar();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      await todoRepository.initIsar(); // Isar 초기화
      todos = await todoRepository.getTodos();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록 앱'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showAddDialog(),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () => showDetailDialog(index),
                  trailing: SizedBox(
                    width: 96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showEditDialog(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => showDeleteDialog(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
    );
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        return AlertDialog(
          title: const Text('할 일 추가하기'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(labelText: '제목'),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: const InputDecoration(labelText: '설명'),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('추가'),
              onPressed: () async {
                Navigator.of(context).pop();

                TodoIsar newTodo = TodoIsar()
                  ..title = title
                  ..description = description;
                await todoRepository.addTodo(newTodo);
                List<TodoIsar> newTodos = await todoRepository.getTodos();
                setState(() {
                  todos = newTodos;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showDetailDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('할 일'),
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text('제목 : ${todos[index].title}'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text('설명 : ${todos[index].description}'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = todos[index].title;
        String? description = todos[index].description;
        return AlertDialog(
          title: const Text('할 일 수정하기'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    hintText: todos[index].title,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(
                    hintText: todos[index].description,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('수정'),
              onPressed: () async {
                Navigator.of(context).pop();

                TodoIsar targetTodo = todos[index]
                  ..title = title
                  ..description = description;
                await todoRepository.updateTodo(targetTodo);
                List<TodoIsar> newTodos = await todoRepository.getTodos();
                setState(() {
                  todos = newTodos;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('할 일 삭제하기'),
          content: const Text('삭제 하시겠습니까?'),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('삭제'),
              onPressed: () async {
                Navigator.of(context).pop();

                await todoRepository.deleteTodo(todos[index].id);
                List<TodoIsar> newTodos = await todoRepository.getTodos();
                setState(() {
                  todos = newTodos;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
