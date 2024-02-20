// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoItemHash() => r'598955ebdb957dc7bf5ec5149a9d38a113b15cb9';

/// performance optimization
/// that we'll use to provide the value of an individual todo
///
/// Copied from [todoItem].
@ProviderFor(todoItem)
final todoItemProvider = AutoDisposeProvider<Todo>.internal(
  todoItem,
  name: r'todoItemProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoItemHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef TodoItemRef = AutoDisposeProviderRef<Todo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
