import 'package:meta/meta.dart';
import 'package:pharmacy_website/src/components/components.dart';
import 'package:pharmacy_website/src/factories/now.dart';
import 'package:pharmacy_website/src/models/pharmacy.dart';
import 'package:pharmacy_website/src/template/common.dart';

class ScheduleHtml extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  ScheduleHtml({
    @required this.pharmacy,
    this.openType = OpenType.close,
    this.nowFactory = defaultNowFactory,
  });

  @override
  String render() {
    return '''<!DOCTYPE html>
<html>
${Head(pharmacy: pharmacy).render()}
${Body(pharmacy: pharmacy, openType: openType, nowFactory: nowFactory).render()}
</html>''';
  }
}

class Head extends Component {
  final Pharmacy pharmacy;

  Head({@required this.pharmacy});

  @override
  String render() {
    return '''<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="keywords" content="Santetis, Pharmacie, ${pharmacy.name}, ${pharmacy.address.city}" />
  <meta name="description" content="Le site de la ${pharmacy.name} à ${pharmacy.address.city} vous permet de retrouver facilement les horaires, les coordonées et les services proposés par votre pharmacie" />
  <meta itemprop="name" content="Pharmacie du parc" />
  <meta itemprop="description" content="Le site de la ${pharmacy.name} permet à ses clients d'obtenir rapidement ses coordonnées et ses horaires. Le site permet de visualiser les champs de compétence et les service que propose la pharmacie." />
  <meta name="Category" content="Site de pharmacie" />
  <meta name="author" content="Santetis" />
  <meta name="reply-to" content="kevin@santetis.fr" />
  <meta name="robots" content="index, follow" />
  <meta name="googlebot" content="index, follow" />
  <meta name="revisit-after" content="10 days" />
  <meta name="copyright" content="Santetis - Rieumes 31370 - https://santetis.fr" />
  <meta name="theme-color" content="#1FA463">
  
  <title>${pharmacy.name} à ${pharmacy.address.city}</title>
  
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/schedule.css">
  <link rel="stylesheet" media="(min-width: 740px)" href="/css/schedule-desktop.css">
  <link rel="stylesheet" media="(max-width: 739px)" href="/css/schedule-mobile.css">
</head>''';
  }
}

class Body extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  Body({
    @required this.pharmacy,
    this.openType = OpenType.close,
    @required this.nowFactory,
  });

  @override
  Component build() {
    return BodyComponent(
      children: [
        TopBar(
          pharmacy: pharmacy,
          openType: openType,
          backHref: '../',
          nowFactory: nowFactory,
        ),
        Content(
          pharmacy: pharmacy,
          openType: openType,
          nowFactory: nowFactory,
        ),
      ],
    );
  }
}

class Content extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  Content({
    @required this.pharmacy,
    @required this.nowFactory,
    this.openType = OpenType.close,
  });

  @override
  Component build() {
    final now = nowFactory();
    final nextDuty = pharmacy.dutyDates.firstWhere(
      (date) =>
          now.isBefore(date) ||
          (now.day == date.day &&
              now.month == date.month &&
              now.year == date.year),
      orElse: () => null,
    );
    return DivComponent(
      classes: ['content'],
      children: [
        PageTitle(iconName: 'schedule', text: 'Horaires'),
        DivComponent(
          classes: ['mobile-state-container'],
          children: [
            MobileState(
              pharmacy: pharmacy,
              openType: openType,
              nowFactory: nowFactory,
            ),
          ],
        ),
        Schedule(
          pharmacy: pharmacy,
          openType: openType,
          nowFactory: nowFactory,
        ),
        if (nextDuty != null) ...[
          DivComponent(
            classes: ['duty-title'],
            children: [
              Title(
                iconName: 'emoji_transportation',
                text: 'Jour de garde',
              ),
            ],
          ),
          DutySchedule(
            dutyTimeSlot: pharmacy.dutyTimeSlot,
            openType: openType,
            nextDutyDate: nextDuty,
          ),
        ]
      ],
    );
  }
}

class Schedule extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  Schedule({
    @required this.pharmacy,
    @required this.nowFactory,
    this.openType = OpenType.close,
  });

  @override
  Component build() {
    final now = nowFactory();
    return DivComponent(
      classes: ['schedule-content'],
      children: [
        for (var i = 0; i < pharmacy.weekDays.length; i++)
          if (pharmacy.weekDays[
                  ((now.weekday - 1) + i) % pharmacy.weekDays.length] !=
              null)
            Day(
              weekDay: pharmacy
                  .weekDays[((now.weekday - 1) + i) % pharmacy.weekDays.length],
              isToday: ((now.weekday - 1) + i) % pharmacy.weekDays.length ==
                  now.weekday - 1,
              isOpen: openType == OpenType.duty || openType == OpenType.open,
              isOnDuty: openType == OpenType.duty,
            ),
      ],
    );
  }
}

class Day extends Component {
  final WeekDay weekDay;
  final bool isToday;
  final bool isOpen;
  final bool isOnDuty;

  Day({
    @required this.weekDay,
    this.isToday = false,
    this.isOpen = false,
    this.isOnDuty = false,
  });

  @override
  Component build() {
    final classes = [];
    if (!isOnDuty) {
      if (isToday) {
        if (isOpen) {
          classes.add('open');
        } else {
          classes.add('close');
        }
      }
    }
    return ColumnComponent(
      classes: [
        'day',
        ...classes,
      ],
      children: [
        SpanComponent(
          text: weekDay.name,
          classes: ['day-name'],
        ),
        ColumnComponent(
          children: [
            for (final timeSlot in weekDay.slots) ...[
              SpanComponent(
                text: timeSlot.readableTimeSlot(),
                classes: ['day-timeslot'],
              ),
            ]
          ],
        ),
      ],
    );
  }
}

class DutySchedule extends Component {
  final DateTime nextDutyDate;
  final List<TimeSlot> dutyTimeSlot;
  final OpenType openType;

  DutySchedule(
      {@required this.dutyTimeSlot,
      @required this.nextDutyDate,
      this.openType = OpenType.close});

  @override
  Component build() {
    final now = DateTime.now().toUtc().add(Duration(hours: 1));
    return DivComponent(
      classes: ['duty-schedule-content'],
      children: [
        DutyDay(
          name:
              '${nextDutyDate.day.toString().padLeft(2, '0')}/${nextDutyDate.month.toString().padLeft(2, '0')}/${nextDutyDate.year}',
          isToday: now.day == nextDutyDate.day &&
              now.month == nextDutyDate.month &&
              now.year == nextDutyDate.year,
          isOpen: dutyTimeSlot
              .map((timeSlot) => timeSlot.isInSlot(now.hour, now.minute))
              .contains(true),
          timeSlots: dutyTimeSlot,
        )
      ],
    );
  }
}

class DutyDay extends Component {
  final List<TimeSlot> timeSlots;
  final String name;
  final bool isToday;
  final bool isOpen;

  DutyDay({
    @required this.name,
    this.timeSlots = const [],
    this.isToday = false,
    this.isOpen = false,
  });

  @override
  Component build() {
    return ColumnComponent(
      classes: [
        'day',
        if (isToday) if (isOpen) 'open' else 'close',
      ],
      children: [
        SpanComponent(
          text: name,
          classes: ['day-name'],
        ),
        ColumnComponent(
          children: [
            for (final timeSlot in timeSlots) ...[
              SpanComponent(
                text: timeSlot.readableTimeSlot(),
                classes: ['day-timeslot'],
              ),
            ]
          ],
        ),
      ],
    );
  }
}
