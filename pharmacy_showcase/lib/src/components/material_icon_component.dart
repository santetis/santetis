import 'package:meta/meta.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';
import 'package:pharmacy_showcase/src/components/raw_text_component.dart';

class MaterialIconComponent extends HtmlComponent {
  MaterialIconComponent(
      {List<String> classes = const [], @required String iconName})
      : assert(iconName != null),
        super(
          tag: 'i',
          classes: [...classes, 'material-icons'],
          children: [RawTextComponent(iconName)],
        );
}
