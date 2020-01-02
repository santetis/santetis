import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';

class ListItemComponent extends HtmlComponent {
  ListItemComponent({List<String> classes = const [], List<Component> children})
      : super(tag: 'li', classes: classes, children: children);
}
