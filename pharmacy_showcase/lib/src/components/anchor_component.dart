import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';

class AnchorComponent extends HtmlComponent {
  AnchorComponent(
      {List<String> classes = const [], String href, List<Component> children})
      : super(tag: 'a', href: href, classes: classes, children: children);
}
