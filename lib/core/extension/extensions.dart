extension ExtensionOnList on List {
  double get average {
    return fold(0, (a, b) => (a + b).toInt()) / length;
  }
}
