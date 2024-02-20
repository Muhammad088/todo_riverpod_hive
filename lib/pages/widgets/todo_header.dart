import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = const SizedBox.shrink();

  Widget getActiveTodoCount(List<Todo> todos) {
    final totalCount = todos.length;
    final activeTodoCount =
        todos.where((element) => !element.completed).toList().length;

    prevTodoCountWidget = Text(
      '$activeTodoCount/$totalCount Items left',
      style: TextStyle(fontSize: 18, color: Colors.blue[900]),
    );

    return prevTodoCountWidget;
  }

  @override
  Widget build(BuildContext context) {
    final todosListState = ref.watch(todoListProvider);

    todosListState.maybeWhen(
      skipLoadingOnRefresh: false, // false: id don't want to skip loading
      loading: () {
        context.loaderOverlay.show();
      },
      orElse: () {
        context.loaderOverlay.hide();
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Todo',
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 10),
            todosListState.maybeWhen(
              orElse: () => prevTodoCountWidget,
              data: (todos) => getActiveTodoCount(todos),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.light_mode),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                ref.invalidate(todoListProvider);
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ],
    );
  }
}
