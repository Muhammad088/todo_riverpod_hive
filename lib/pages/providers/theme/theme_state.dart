sealed class ThemeState {
  const ThemeState();
}

class DarkTheme extends ThemeState {
  const DarkTheme();

  @override
  String toString() => "DarkTheme()";
}

class LightTheme extends ThemeState {
  const LightTheme();

  @override
  String toString() => "LightTheme()";
}
