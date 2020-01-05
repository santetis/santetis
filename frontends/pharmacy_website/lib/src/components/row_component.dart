import 'package:meta/meta.dart';
import 'package:pharmacy_website/src/components/component.dart';
import 'package:pharmacy_website/src/components/div_component.dart';

class RowComponent extends Component {
  final List<Component> children;
  final List<String> classes;

  RowComponent({this.classes = const [], @required this.children})
      : assert(children != null);

  @override
  Component build() {
    return DivComponent(
      classes: [...classes, 'row'],
      children: children,
    );
  }
}
