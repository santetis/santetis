import 'package:pharmacy_website/src/components/component.dart';
import 'package:pharmacy_website/src/components/html_component.dart';

class SectionComponent extends HtmlComponent {
  SectionComponent({List<Component> children, List<String> classes})
      : super(tag: 'section', classes: classes, children: children);
}
