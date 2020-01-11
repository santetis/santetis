import 'package:pharmacy_website/src/models/pharmacy.dart';
import 'package:pharmacy_website/src/template/common.dart';
import 'package:test/test.dart';

final pharmacy = Pharmacy(
  weekDays: [
    WeekDay(
      'Lundi',
      [
        TimeSlot(Hour(9, 30), Hour(19, 30)),
      ],
    ),
    null,
    null,
    null,
    null,
    null,
    null,
  ],
  dutyDates: [
    DateTime.utc(2020, 01, 07),
  ],
  dutyTimeSlot: [
    TimeSlot(Hour(10, 0), Hour(12, 0)),
  ],
);

void main() {
  test('is open', () {
    final fakeNow = () {
      return DateTime.utc(2020, 01, 06, 10);
    };

    final openType = getOpenType(pharmacy, fakeNow());
    expect(openType, OpenType.open);
  });

  test('is close', () {
    final fakeNow = () {
      return DateTime.utc(2020, 01, 06, 9);
    };

    final openType = getOpenType(pharmacy, fakeNow());
    expect(openType, OpenType.close);
  });

  test('is duty', () {
    final fakeNow = () {
      return DateTime.utc(2020, 01, 07, 10, 01);
    };

    final openType = getOpenType(pharmacy, fakeNow());
    expect(openType, OpenType.duty);
  });

  test('duty day but closed', () {
    final fakeNow = () {
      return DateTime.utc(2020, 01, 07, 13);
    };

    final openType = getOpenType(pharmacy, fakeNow());
    expect(openType, OpenType.close);
  });
}
