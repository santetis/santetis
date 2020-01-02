import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';

class UnorderedListComponent extends HtmlComponent {
  UnorderedListComponent(
      {List<String> classes = const [], List<Component> children})
      : super(tag: 'ul', classes: classes, children: children);
}
