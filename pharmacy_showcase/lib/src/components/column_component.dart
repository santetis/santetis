import 'package:meta/meta.dart';
import 'package:pharmacy_showcase/src/components/component.dart';
import 'package:pharmacy_showcase/src/components/div_component.dart';

class ColumnComponent extends Component {
  final List<Component> children;
  final List<String> classes;

  ColumnComponent({this.classes = const [], @required this.children})
      : assert(children != null);

  @override
  String render() {
    return DivComponent(
      classes: [...classes, 'column'],
      children: children,
    ).render();
  }
}
