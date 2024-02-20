import 'dart:math';

import 'package:hive/hive.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/todos_repository.dart';

class HiveTodosRepository extends TodosRepository {
  final Box todoBox = Hive.box("todos");

  @override
  Future<List<Todo>> getTodos() async {
    try {
      // to test errors
      final Random random = Random();
      if (random.nextDouble() < 0.5) {
        throw 'fail to retrieve todos';
      }

      if (todoBox.length == 0) return [];
      return [
        for (final todo in todoBox.values)
          Todo.fromJson(Map<String, dynamic>.from(todo))
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    try {
      await todoBox.put(todo.id, todo.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    try {
      final todoMap = todoBox.get(id);
      todoMap['desc'] = desc;
      await todoBox.put(id, todoMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    try {
      final todoMap = todoBox.get(id);
      todoMap['completed'] = !todoMap['completed'];
      await todoBox.put(id, todoMap);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    try {
      await todoBox.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
