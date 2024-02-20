import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'todo_search_provider.g.dart';

/// this provider to provide a word for search for some todos by searchTerm
@riverpod
class TodoSearch extends _$TodoSearch {
  @override
  String build() {
    return "";
  }

  void setSearchTerm(String newSearchTerm) {
    state = newSearchTerm;
  }
}
