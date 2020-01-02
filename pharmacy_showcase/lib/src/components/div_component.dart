import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';

class DivComponent extends HtmlComponent {
  DivComponent(
      {List<String> classes = const [], String id, List<Component> children})
      : super(tag: 'div', id: id, classes: classes, children: children);
}
