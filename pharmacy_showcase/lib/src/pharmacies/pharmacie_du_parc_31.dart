import 'package:pharmacy_showcase/src/models/address.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';
import 'package:pharmacy_showcase/src/pharmacies/common_time_slot.dart';

final pharmacieDuParc31 = Pharmacy(
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
    DateTime.utc(2020, 01, 05),
  ],
  dutyTimeSlot: allDayTimeSlot,
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
