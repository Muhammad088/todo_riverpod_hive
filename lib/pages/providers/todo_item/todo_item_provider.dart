import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
part 'todo_item_provider.g.dart';

/// performance optimization
/// that we'll use to provide the value of an individual todo
@Riverpod(dependencies: [])
Todo todoItem(TodoItemRef ref) {
  throw UnimplementedError();
}
