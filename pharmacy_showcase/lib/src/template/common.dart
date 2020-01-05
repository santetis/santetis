import 'package:meta/meta.dart';
import 'package:pharmacy_showcase/src/components/components.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';

enum OpenType {
  open,
  duty,
  close,
}

OpenType getOpenType(Pharmacy pharmacy) {
  final publicHolidays = [
    DateTime.utc(2020, 1, 1),
    DateTime.utc(2020, 4, 13),
    DateTime.utc(2020, 5, 1),
    DateTime.utc(2020, 5, 8),
    DateTime.utc(2020, 5, 21),
    DateTime.utc(2020, 6, 1),
    DateTime.utc(2020, 7, 14),
    DateTime.utc(2020, 8, 15),
    DateTime.utc(2020, 11, 1),
    DateTime.utc(2020, 11, 11),
    DateTime.utc(2020, 12, 25),
  ];
  final now = DateTime.now().toUtc().add(Duration(hours: 1));
  final today = DateTime.utc(now.year, now.month, now.day);

  for (final publicHoliday in publicHolidays) {
    if (today.isAtSameMomentAs(publicHoliday)) {
      if (pharmacy.dutyTimeSlot
          .map((timeSlot) => timeSlot.isInSlot(now.hour, now.minute))
          .contains(true)) {
        return OpenType.duty;
      }
      return OpenType.close;
    }
  }

  final weekday = now.weekday - 1;
  final day = pharmacy.weekDays[weekday];
  if (day?.isInDay(now) == true) {
    return OpenType.open;
  }
  final dutyDate = pharmacy.dutyDates?.firstWhere(
      (dutydate) => dutydate.isAtSameMomentAs(today),
      orElse: () => null);
  if (dutyDate != null) {
    for (final timeslot in pharmacy.dutyTimeSlot ?? []) {
      if (timeslot.isInSlot(now.hour, now.minute)) {
        return OpenType.duty;
      }
    }
  }
  return OpenType.close;
}

class TopBar extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final String backHref;

  TopBar({@required this.pharmacy, this.openType, this.backHref});

  @override
  Component build() {
    Component pharmacyName = SpanComponent(
      text: pharmacy.name,
      classes: [
        'grey',
        'pharmacy-name',
        if (backHref == null || backHref.isEmpty) 'flexible-1'
      ],
    );
    if (backHref?.isNotEmpty == true) {
      pharmacyName = AnchorComponent(
        classes: ['no-text-decoration', 'flexible-1'],
        href: backHref,
        children: [pharmacyName],
      );
    }

    return DivComponent(
      classes: ['top-bar'],
      children: [
        RowComponent(
          classes: ['center-top-bar-content'],
          children: [
            pharmacyName,
            State(pharmacy: pharmacy, openType: openType),
          ],
        ),
      ],
    );
  }
}

class State extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final bool isDesktop;

  State({
    @required this.pharmacy,
    this.openType = OpenType.close,
    this.isDesktop = true,
  });

  @override
  Component build() {
    final closeAt = readableNext();
    var text = 'FERMÉ';
    if (openType == OpenType.open || openType == OpenType.duty) {
      text = openType == OpenType.open ? 'OUVERT' : 'DE GARDE';
      if (closeAt.isNotEmpty) {
        text += ' - $closeAt';
      }
    }

    return RowComponent(
      classes: [
        'state-container-${isDesktop ? 'desktop' : 'mobile'}',
        'v-center',
      ],
      children: [
        DivComponent(
          classes: [
            'pharmacy-state',
            if (openType == OpenType.open || openType == OpenType.duty)
              'green-background'
            else
              'red-background'
          ],
        ),
        SpanComponent(
          text: openType == OpenType.open || openType == OpenType.duty
              ? text
              : 'FERMÉ',
          classes: ['state-text'],
        ),
      ],
    );
  }

  TimeSlot getCurrentTimeSlot(List<TimeSlot> timeSlots, Hour hour) =>
      timeSlots.firstWhere(
          (timeSlot) => timeSlot.isInSlot(hour.hour, hour.minute),
          orElse: () => null);

  String readableNext() {
    final sb = StringBuffer();
    final now = DateTime.now().toUtc().add(Duration(hours: 1));
    if (openType == OpenType.open || openType == OpenType.duty) {
      final currentTimeSlot = getCurrentTimeSlot(
        openType == OpenType.open
            ? pharmacy.weekDays[now.weekday - 1]
            : pharmacy.dutyTimeSlot,
        Hour(now.hour, now.minute),
      );
      if (currentTimeSlot == null) {
        return '';
      }
      sb.write('Fermeture à ${currentTimeSlot.end.toString()}');
    }
    return sb.toString();
  }
}

class SantetisCopyright extends Component {
  @override
  Component build() {
    return DivComponent(
      classes: ['santetis-copryright-container'],
      children: [
        SpanComponent(
          text: 'Site généré par Santetis. Tout droit réservé',
        )
      ],
    );
  }
}

class Title extends Component {
  final String iconName;
  final String text;

  Title({this.iconName, this.text});

  @override
  Component build() {
    return RowComponent(
      classes: ['v-center', 'h-center', 'page-title'],
      children: [
        MaterialIconComponent(
          iconName: iconName,
          classes: ['page-title-icon-size'],
        ),
        SpanComponent(
          text: text,
          classes: ['page-title-style'],
        ),
      ],
    );
  }
}

class PageTitle extends Component {
  final String iconName;
  final String text;

  PageTitle({this.iconName, this.text});

  @override
  Component build() {
    return DivComponent(
      classes: ['page-title-content'],
      children: [
        Title(
          iconName: iconName,
          text: text,
        ),
      ],
    );
  }
}

class MobileState extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;

  MobileState({@required this.pharmacy, this.openType = OpenType.close});

  @override
  Component build() {
    return State(pharmacy: pharmacy, isDesktop: false, openType: openType);
  }
}
