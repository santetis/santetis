import 'package:pharmacy_website/src/pharmacies/pharmacie_du_parc_31.dart';
import 'package:pharmacy_website/src/template/common.dart';
import 'package:pharmacy_website/src/template/pharmacy.dart';
import 'package:test/test.dart';
import 'package:html/parser.dart';

void main() {
  test('home page', () async {
    final content = PharmacyHtml(
      pharmacy: pharmacieDuParc31,
      nowFactory: () => DateTime.now().toUtc(),
    ).render();
    final dom = parse(content);
    final contactUsItems =
        dom.querySelectorAll('.content .contact-us .column ul li');
    final elementItems = contactUsItems
        .map((item) => item.children.first.children.first.children.last)
        .toList();
    expect(elementItems[0].innerHtml, '0561733157');
    expect(elementItems[1].innerHtml, 'leparc31@gmail.com');
    expect(elementItems[2].children.map((child) => child.innerHtml).join(' '),
        '63 Avenue tolosane 31520 Ramonville-Saint-Agne');
    final practicalsInformationsItems =
        dom.querySelectorAll('.content .practical-informations .column ul li');
    final textItems = practicalsInformationsItems
        .map((item) => item.children.first.children.last.innerHtml)
        .toList();
    final expectedText = [
      'Parking privé',
      'Accès handicapé',
      'WC',
      'Places assises',
      'Jouet pour enfant',
      'Animaux acceptés'
    ];
    expect(textItems.length, expectedText.length);
    for (var i = 0; i < textItems.length; i++) {
      expect(textItems[i], expectedText[i]);
    }
  });

  group('desktop open infos', () {
    test('is open', () async {
      final openNow = () => DateTime.utc(2020, 01, 11, 10, 30);
      final openType = getOpenType(pharmacieDuParc31, openNow());
      final content = PharmacyHtml(
        pharmacy: pharmacieDuParc31,
        openType: openType,
        nowFactory: openNow,
      ).render();
      final dom = parse(content);
      final stateContainer = dom.querySelector(
          '.top-bar .center-top-bar-content .state-container-desktop');
      expect(stateContainer.children.first.classes.contains('green-background'),
          isTrue);
      expect(
          stateContainer.children.last.innerHtml, 'OUVERT - Fermeture à 12h30');
    });

    test('is close', () async {
      final closeNow = () => DateTime.utc(2020, 01, 11, 20, 30);
      final openType = getOpenType(pharmacieDuParc31, closeNow());
      final content = PharmacyHtml(
        pharmacy: pharmacieDuParc31,
        openType: openType,
        nowFactory: closeNow,
      ).render();
      final dom = parse(content);
      final stateContainer = dom.querySelector(
          '.top-bar .center-top-bar-content .state-container-desktop');
      expect(stateContainer.children.first.classes.contains('red-background'),
          isTrue);
      expect(stateContainer.children.last.innerHtml, 'FERMÉ');
    });

    test('open duty', () async {
      final openDutyNow = () => DateTime.utc(2020, 03, 15, 16, 30);
      final openType = getOpenType(pharmacieDuParc31, openDutyNow());
      final content = PharmacyHtml(
        pharmacy: pharmacieDuParc31,
        openType: openType,
        nowFactory: openDutyNow,
      ).render();
      final dom = parse(content);
      final stateContainer = dom.querySelector(
          '.top-bar .center-top-bar-content .state-container-desktop');
      expect(stateContainer.children.first.classes.contains('green-background'),
          isTrue);
      expect(stateContainer.children.last.innerHtml,
          'DE GARDE - Fermeture à 19h30');
    });

    test('close duty', () async {
      final closeDutyNow = () => DateTime.utc(2020, 03, 15, 13, 30);
      final openType = getOpenType(pharmacieDuParc31, closeDutyNow());
      final content = PharmacyHtml(
        pharmacy: pharmacieDuParc31,
        openType: openType,
        nowFactory: closeDutyNow,
      ).render();
      final dom = parse(content);
      final stateContainer = dom.querySelector(
          '.top-bar .center-top-bar-content .state-container-desktop');
      expect(stateContainer.children.first.classes.contains('red-background'),
          isTrue);
      expect(stateContainer.children.last.innerHtml, 'FERMÉ');
    });
  });
}
