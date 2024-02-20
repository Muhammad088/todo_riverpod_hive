import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/pages/providers/theme/theme_state.dart';

part 'theme_provider.g.dart';

/// this provider to toggle between dark and light mode
@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    return const LightTheme();
  }

  void toggleTheme() {
    state = switch (state) {
      DarkTheme() => const LightTheme(),
      LightTheme() => const DarkTheme(),
    };
  }
}
