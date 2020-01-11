import 'package:html/parser.dart';
import 'package:pharmacy_website/src/pharmacies/pharmacie_du_parc_31.dart';
import 'package:pharmacy_website/src/template/common.dart';
import 'package:pharmacy_website/src/template/schedule.dart';
import 'package:test/test.dart';

void main() {
  group('schedule page', () {
    test('weekday list', () async {
      final nowIsMondayAndOpen = () => DateTime.utc(2020, 01, 13, 10);
      final openType = getOpenType(pharmacieDuParc31, nowIsMondayAndOpen());
      final content = ScheduleHtml(
        pharmacy: pharmacieDuParc31,
        openType: openType,
        nowFactory: nowIsMondayAndOpen,
      ).render();
      final dom = parse(content);
      final weekday = dom.querySelectorAll('.content .schedule-content .day');
      expect(weekday[0].children.first.innerHtml, 'Lundi');
      expect(weekday[1].children.first.innerHtml, 'Mardi');
      expect(weekday[2].children.first.innerHtml, 'Mercredi');
      expect(weekday[3].children.first.innerHtml, 'Jeudi');
      expect(weekday[4].children.first.innerHtml, 'Vendredi');
      expect(weekday[5].children.first.innerHtml, 'Samedi');
      expect(
          weekday[0]
              .children
              .last
              .children
              .map((timeslot) => timeslot.innerHtml)
              .join(' '),
          'de 08h30 à 19h30');
      expect(
          weekday[2]
              .children
              .last
              .children
              .map((timeslot) => timeslot.innerHtml)
              .join(' '),
          'de 09h00 à 12h30 de 14h00 à 19h30');
    });

    group('duty', () {
      test('show next duty', () async {
        final fakeNow = () => DateTime.utc(2020, 01, 13, 10);
        final openType = getOpenType(pharmacieDuParc31, fakeNow());
        final content = ScheduleHtml(
          pharmacy: pharmacieDuParc31,
          openType: openType,
          nowFactory: fakeNow,
        ).render();
        final dom = parse(content);
        final duty = dom.querySelector('.content .duty-schedule-content');
        expect(duty.children.length, 1);
        expect(duty.children.first.children.first.innerHtml, '15/03/2020');
        expect(
            duty.children.first.children.last.children
                .map((timeSlot) => timeSlot.innerHtml)
                .join(' '),
            'de 09h00 à 12h30 de 15h00 à 19h30');
      });
    });

    group('today', () {
      test('is open', () async {
        final fakeNow = () => DateTime.utc(2020, 01, 13, 10);
        final openType = getOpenType(pharmacieDuParc31, fakeNow());
        final content = ScheduleHtml(
          pharmacy: pharmacieDuParc31,
          openType: openType,
          nowFactory: fakeNow,
        ).render();
        final dom = parse(content);
        final weekday = dom.querySelectorAll('.content .schedule-content .day');
        expect(weekday.first.classes.contains('open'), isTrue);
      });

      test('is close', () async {
        final fakeNow = () => DateTime.utc(2020, 01, 13, 21);
        final openType = getOpenType(pharmacieDuParc31, fakeNow());
        final content = ScheduleHtml(
          pharmacy: pharmacieDuParc31,
          openType: openType,
          nowFactory: fakeNow,
        ).render();
        final dom = parse(content);
        final weekday = dom.querySelectorAll('.content .schedule-content .day');
        expect(weekday.first.classes.contains('close'), isTrue);
      });

      test('open duty', () async {
        final fakeNow = () => DateTime.utc(2020, 1, 5, 10);
        final openType = getOpenType(pharmacieDuParc31, fakeNow());
        final content = ScheduleHtml(
          pharmacy: pharmacieDuParc31,
          openType: openType,
          nowFactory: fakeNow,
        ).render();
        final dom = parse(content);
        final weekday = dom.querySelectorAll('.content .schedule-content .day');
        expect(weekday.first.classes.contains('open'), isFalse);
        expect(weekday.first.classes.contains('close'), isFalse);
      });

      test('close duty', () async {
        final fakeNow = () => DateTime.utc(2020, 1, 5, 20);
        final openType = getOpenType(pharmacieDuParc31, fakeNow());
        final content = ScheduleHtml(
          pharmacy: pharmacieDuParc31,
          openType: openType,
          nowFactory: fakeNow,
        ).render();
        final dom = parse(content);
        final weekday = dom.querySelectorAll('.content .schedule-content .day');
        expect(weekday.first.classes.contains('close'), isFalse);
        expect(weekday.first.classes.contains('open'), isFalse);
      });
    });
  });

  group('desktop open infos', () {
    test('is open', () async {
      final openNow = () => DateTime.utc(2020, 01, 11, 10, 30);
      final openType = getOpenType(pharmacieDuParc31, openNow());
      final content = ScheduleHtml(
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
      final content = ScheduleHtml(
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
      final content = ScheduleHtml(
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
      final content = ScheduleHtml(
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
