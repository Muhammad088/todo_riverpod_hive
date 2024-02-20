import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/repositories/todos_repository.dart';
part 'todos_repository_provider.g.dart';

/// this repository provider to connect to the api
@riverpod
TodosRepository todosRepository(TodosRepositoryRef ref) {
  throw UnimplementedError();
}

/*
The reason for this is so that the repository instance
returned by todosRepositoryProvider
can be easily swapped out
depending on which API endpoint we're using.
And since FakeTodosRepository is a subclass of TodosRepository,
it's okay to return it from todosRepositoryProvider.
If we want to use FirebaseTodosRepository in the future,
we can return FirebaseTodosRepository
instead of FakeTodosRepository.
 */