import 'package:pharmacy_website/src/components/component.dart';

class RawTextComponent extends Component {
  final String text;

  RawTextComponent(this.text);

  @override
  String render() => text;
}
