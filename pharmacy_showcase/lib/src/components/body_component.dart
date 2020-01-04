import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';

class BodyComponent extends HtmlComponent {
  BodyComponent({List<String> classes = const [], List<Component> children})
      : super(tag: 'body', classes: classes, children: children);
}
