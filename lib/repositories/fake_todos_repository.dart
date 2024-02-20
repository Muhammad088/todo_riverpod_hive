import 'dart:math';

import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/todos_repository.dart';

final initialTodos = [
  {"id": "1", "desc": "Clean the room", "completed": false},
  {"id": "2", "desc": "Wash the dish", "completed": false},
  {"id": "3", "desc": "Do homework", "completed": false},
];

const double kProbabilityOfError = 0.5;
const int kDelayDuration = 1;

class FakeTodosRepository extends TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initialTodos;
  final Random random = Random();

  Future<void> waitSeconds() {
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Todo>> getTodos() async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'fail to retrieve todos';
      }
      return [for (final todo in fakeTodos) Todo.fromJson(todo)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'fail to add todo';
      }
      fakeTodos = [...fakeTodos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'fail to edit todo';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          todo["id"] == id
              ? {"id": id, "desc": desc, "completed": todo["completed"]}
              : todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'fail to toggle todo';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          todo["id"] == id
              ? {
                  "id": id,
                  "desc": todo["desc"],
                  "completed": !todo["completed"]
                }
              : todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSeconds();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'fail to remove todo';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo["id"] != id) todo
      ];
    } catch (e) {
      rethrow;
    }
  }
}
