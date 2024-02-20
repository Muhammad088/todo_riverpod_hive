import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_filter/todo_filter_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_item/todo_item_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_search/todo_search_provider.dart';
import 'package:todo_riverpod_sync/pages/widgets/todo_item.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  Widget prevTodosWidget = const SizedBox.shrink();

  List<Todo> filterTodos(List<Todo> allTodos) {
    // final todoListState = ref.watch(todoListProvider);
    final filter = ref.watch(todoFilterProvider);
    final search = ref.watch(todoSearchProvider);

    List<Todo> tempTodos;

    tempTodos = switch (filter) {
      Filter.active => allTodos.where((element) => !element.completed).toList(),
      Filter.completed =>
        allTodos.where((element) => element.completed).toList(),
      Filter.all => allTodos,
    };

    if (search.isNotEmpty) {
      tempTodos = tempTodos
          .where((element) =>
              element.desc.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return tempTodos;
  }

  @override
  Widget build(BuildContext context) {
    // this listen method to show dialog if some error happened with the data
    ref.listen<AsyncValue<List<Todo>>>(todoListProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) {
          if (!next.isLoading) {
            showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text(
                    "Error",
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          }
        },
      );
    });
    final todoListState = ref.watch(todoListProvider);
    return todoListState.when(
      skipError: true,
      data: (todos) {
        final filteredTodos = filterTodos(todos);
        prevTodosWidget = ListView.separated(
          itemCount: filteredTodos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            final todo = filteredTodos[index];
            return ProviderScope(
              overrides: [
                todoItemProvider.overrideWithValue(todo),
              ],
              child: const TodoItem(),
            );
          },
        );
        return prevTodosWidget;
      },
      error: (error, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  ref.invalidate(todoListProvider);
                },
                child: const Text(
                  'Please Retry!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      },
      loading: () {
        return prevTodosWidget;
      },
    );
  }
}
