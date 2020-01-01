import 'package:meta/meta.dart';

abstract class Component {
  String render();
}

class HtmlComponent extends Component {
  final String tag;
  final String id;
  final List<String> classes;
  final List<Component> children;

  HtmlComponent({this.tag, this.classes, this.id, this.children});

  @override
  String render() {
    final sb = StringBuffer('<$tag');
    if (classes?.isNotEmpty == true) {
      sb.write(' class="${classes.join(' ')}"');
    }
    if (id?.isNotEmpty == true) {
      sb.write(' id="$id"');
    }
    sb.write('>');
    if (children != null) {
      sb.write(children.map((child) => child.render()).join());
    }
    sb.write('</$tag>');
    return sb.toString();
  }
}

class RenderRawTextComponent extends Component {
  final String text;

  RenderRawTextComponent(this.text);

  @override
  String render() => text;
}

class DivComponent extends HtmlComponent {
  DivComponent(
      {List<String> classes = const [], @required List<Component> children})
      : assert(children != null),
        super(tag: 'div', classes: classes, children: children);
}

class MaterialIconComponent extends HtmlComponent {
  MaterialIconComponent(
      {List<String> classes = const [], @required String iconName})
      : assert(iconName != null),
        super(
          tag: 'i',
          classes: [...classes, 'material-icons'],
          children: [RenderRawTextComponent(iconName)],
        );
}

class SectionComponent extends HtmlComponent {
  SectionComponent({@required List<Component> children})
      : assert(children != null),
        super(tag: 'section', children: children);
}

class SpanComponent extends HtmlComponent {
  SpanComponent({List<String> classes = const [], @required String text})
      : assert(text != null),
        super(
            tag: 'span',
            classes: classes,
            children: [RenderRawTextComponent(text)]);
}

class ParagraphComponent extends HtmlComponent {
  ParagraphComponent({List<String> classes = const [], @required String text})
      : assert(text != null),
        super(
            tag: 'p',
            classes: classes,
            children: [RenderRawTextComponent(text)]);
}

class RowComponent extends Component {
  final List<Component> children;
  final List<String> classes;

  RowComponent({this.classes = const [], @required this.children})
      : assert(children != null);

  @override
  String render() {
    return DivComponent(
      classes: [...classes, 'row'],
      children: children,
    ).render();
  }
}

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
