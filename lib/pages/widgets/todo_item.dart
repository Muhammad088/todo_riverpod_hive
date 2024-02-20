import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_item/todo_item_provider.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('building TodoItem');
    final todo = ref.watch(todoItemProvider);
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return ConfirmEditDialog(todo: todo);
            });
      },
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          ref.read(todoListProvider.notifier).toggleTodo(todo.id);
        },
      ),
      title: Text(todo.desc),
      trailing: IconButton(
          onPressed: () async {
            final removeOrNot = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are You Sure ?"),
                  content: const Text("Do you really want to delete ?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
            if (removeOrNot) {
              ref.read(todoListProvider.notifier).removeTodo(todo.id);
            }
          },
          icon: const Icon(Icons.delete)),
    );
  }
}

class ConfirmEditDialog extends ConsumerStatefulWidget {
  const ConfirmEditDialog({super.key, required this.todo});
  final Todo todo;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmEditDialogState();
}

class _ConfirmEditDialogState extends ConsumerState<ConfirmEditDialog> {
  late final TextEditingController textController;
  bool error = false;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.todo.desc);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: textController,
        autofocus: true,
        decoration: InputDecoration(
          errorText: error ? 'value cannot be empty' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: () {
            error = textController.text.isEmpty;
            if (error) {
              setState(() {});
            } else {
              ref.read(todoListProvider.notifier).editTodo(
                    widget.todo.id,
                    textController.text,
                  );
              Navigator.pop(context);
            }
          },
          child: const Text("EDIT"),
        ),
      ],
    );
  }
}