import 'package:meta/meta.dart';
import 'package:pharmacy_showcase/src/components/html_component.dart';
import 'package:pharmacy_showcase/src/components/raw_text_component.dart';

class SpanComponent extends HtmlComponent {
  SpanComponent({List<String> classes = const [], @required String text})
      : assert(text != null),
        super(
            tag: 'span', classes: classes, children: [RawTextComponent(text)]);
}
