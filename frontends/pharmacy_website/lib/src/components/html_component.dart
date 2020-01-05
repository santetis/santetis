import 'package:pharmacy_website/src/components/component.dart';

class HtmlComponent extends Component {
  final String tag;
  final String id;
  final List<String> classes;
  final String href;
  final List<Component> children;

  HtmlComponent({this.tag, this.classes, this.id, this.href, this.children});

  @override
  String render() {
    final sb = StringBuffer('<$tag');
    if (classes?.isNotEmpty == true) {
      sb.write(' class="${classes.join(' ')}"');
    }
    if (id?.isNotEmpty == true) {
      sb.write(' id="$id"');
    }
    if (href?.isNotEmpty == true) {
      sb.write(' href="$href"');
    }
    sb.write('>');
    if (children != null) {
      sb.write(children.map((child) => child?.render()).join());
    }
    sb.write('</$tag>');
    return sb.toString();
  }
}
