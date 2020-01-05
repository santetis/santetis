abstract class Component {
  Component build() => null;

  String render() {
    return build()?.render();
  }
}
