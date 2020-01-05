import 'package:pharmacy_website/src/models/address.dart';

class Pharmacy {
  final String domainName;
  final String name;
  final Address address;
  final String phone;
  final String email;

  final List<WeekDay> weekDays;
  final List<DateTime> dutyDates;
  final List<TimeSlot> dutyTimeSlot;

  final bool privateCarPark;
  final bool handicapAccess;
  final bool wc;
  final bool possibilityToSit;
  final bool childToy;
  final bool acceptAnimals;

  Pharmacy({
    this.domainName,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.weekDays,
    this.dutyDates,
    this.dutyTimeSlot,
    this.privateCarPark = false,
    this.handicapAccess = false,
    this.wc = false,
    this.possibilityToSit = false,
    this.childToy = false,
    this.acceptAnimals = false,
  });

  bool isOpen() {
    final now = DateTime.now();
    final weekday = now.weekday - 1;
    if (weekday > weekDays.length - 1) {
      return false;
    }
    final day = weekDays[weekday];
    return day.isInDay(now);
  }

  bool isDuty() {
    final now = DateTime.now();
    final dutyDate = dutyDates.firstWhere((date) => date.isAtSameMomentAs(now),
        orElse: () => null);
    if (dutyDate == null) {
      return false;
    }
    return dutyTimeSlot
        .map((timeSlot) => timeSlot.isInSlot(now.hour, now.minute))
        .contains(true);
  }
}

class WeekDay {
  final String name;
  final List<TimeSlot> slots;

  WeekDay(this.name, this.slots);

  bool isInDay(DateTime now) {
    for (final slot in slots) {
      if (slot.isInSlot(now.hour, now.minute)) {
        return true;
      }
    }
    return false;
  }
}

class TimeSlot {
  final Hour start;
  final Hour end;

  TimeSlot(this.start, this.end);

  bool isInSlot(num hour, num minute) {
    if (hour == start.hour && minute >= start.minute) {
      return true;
    }
    if (hour > start.hour && hour < end.hour) {
      return true;
    }
    if (hour == end.hour && minute <= end.minute) {
      return true;
    }
    return false;
  }

  String readableTimeSlot() {
    return 'de ${start.readableHour()} à ${end.readableHour()}';
  }

  @override
  String toString() {
    final sb = StringBuffer('TimeSlot{')
      ..write(' ${start.toString()}')
      ..write(' ${end.toString()}')
      ..write(' }');
    return sb.toString();
  }
}

class Hour {
  final int hour;
  final int minute;

  Hour(this.hour, this.minute);

  String readableHour() =>
      '${hour.toString().padLeft(2, '0')}h${minute.toString().padLeft(2, '0')}';

  @override
  String toString() => '${hour}h$minute';
}
