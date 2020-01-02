import 'dart:io';

import 'package:pharmacy_showcase/src/models/address.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';
import 'package:pharmacy_showcase/src/template/home/pharmacy.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'pharmacy_showcase.g.dart';

OpenType getOpenType(Pharmacy pharmacy) {
  final publicHolidays = [
    DateTime.utc(2020, 01, 01),
    DateTime.utc(2020, 01, 06),
  ];
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final weekday = now.weekday;
  final date = publicHolidays.firstWhere(
    (publicHoliday) => publicHoliday.isAtSameMomentAs(today),
    orElse: () => null,
  );
  if (date != null) {
    final dutyDate = pharmacy.dutyDates
        ?.firstWhere((dutydate) => dutydate == date, orElse: () => null);
    if (dutyDate != null) {
      for (final timeslot in pharmacy.dutyTimeSlot ?? []) {
        if (timeslot.isInSlot(now.hour, now.minute)) {
          return OpenType.duty;
        }
      }
    }
    return OpenType.close;
  }
  if (weekday > pharmacy.weekDays.length - 1) {
    return OpenType.close;
  }
  final day = pharmacy.weekDays[weekday];
  if (day.isInDay(now)) {
    return OpenType.open;
  }
  return OpenType.close;
}

class PharmacyShowcase {
  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  @Route.get('/time')
  Response time(Request request) {
    return Response.ok('${DateTime.now()}');
  }

  @Route.get('/pharmacy/<pharmacyId>')
  Future<Response> pharmacy(Request request, String pharmacyId) async {
    //  todo: get data from database
    if (pharmacyId == 'pharmacieduparc31') {
      final allDayTimeSlot = [TimeSlot(Hour(8, 30), Hour(19, 30))];
      final closeDuringLaunchTimeSlots = [
        TimeSlot(Hour(9, 0), Hour(12, 30)),
        TimeSlot(Hour(14, 0), Hour(19, 30)),
      ];

      final pharmacy = Pharmacy(
        domainName: 'pharmaciduparc31',
        name: 'Pharmacie du parc',
        phone: '0561733157',
        email: 'leparc31@gmail.com',
        acceptAnimals: true,
        childToy: true,
        handicapAccess: true,
        possibilityToSit: true,
        privateCarPark: true,
        wc: true,
        weekDays: [
          WeekDay(
            'Lundi',
            allDayTimeSlot,
          ),
          WeekDay(
            'Mardi',
            allDayTimeSlot,
          ),
          WeekDay(
            'Mercredi',
            closeDuringLaunchTimeSlots,
          ),
          WeekDay(
            'Jeudi',
            allDayTimeSlot,
          ),
          WeekDay(
            'Vendredi',
            allDayTimeSlot,
          ),
          WeekDay(
            'Samedi',
            closeDuringLaunchTimeSlots,
          ),
        ],
        dutyDates: [
          DateTime(2020, 01, 06),
        ],
        address: Address(
          streetNumber: 63,
          streetName: 'Avenue tolosane',
          zipCode: '31520',
          city: 'Ramonville-Saint-Agne',
          coordinates: Coordinates(
            latitude: 43.546812,
            longitude: 1.4734,
          ),
        ),
      );

      final openType = getOpenType(pharmacy);
      print(openType);

      final home = Html(pharmacy: pharmacy, openType: openType);
      return Response.ok(
        home.render(),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.html.toString(),
        },
      );
    }
    return Response.notFound('');
  }

  Router get router => _$PharmacyShowcaseRouter(this);
}
