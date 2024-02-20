import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/repositories/providers/todos_repository_provider.dart';

part 'todo_list_provider.g.dart';

/// this provider to get list of all todos and connect with todosRepository to do CRUD

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() {
    print("[todoListProvider] initialized");
    ref.onDispose(() {
      print("[todoListProvider] disposed");
    });
    return _getTodos();
  }

  Future<List<Todo>> _getTodos() async {
    return ref.read(todosRepositoryProvider).getTodos();
  }

  Future<void> addTodo(String desc) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final newTodo = Todo.add(desc);
      await ref.read(todosRepositoryProvider).addTodo(todo: newTodo);
      return [...state.value!, newTodo];
    });
  }

  Future<void> editTodo(String id, String newDesc) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).editTodo(id: id, desc: newDesc);
      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(desc: newDesc) else todo
      ];
    });
  }

  Future<void> toggleTodo(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).toggleTodo(id: id);
      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
      ];
    });
  }

  Future<void> removeTodo(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).toggleTodo(id: id);
      return [
        for (final todo in state.value!)
          if (todo.id != id) todo
      ];
    });
  }
}
