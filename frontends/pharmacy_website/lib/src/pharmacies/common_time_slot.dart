import 'package:pharmacy_website/src/models/pharmacy.dart';

final allDayTimeSlot = [TimeSlot(Hour(8, 30), Hour(19, 30))];
final closeDuringLaunchTimeSlots = [
  TimeSlot(Hour(9, 0), Hour(12, 30)),
  TimeSlot(Hour(14, 0), Hour(19, 30)),
];
final dutyCloseDurintLaunchTimeSlots = [
  TimeSlot(Hour(9, 0), Hour(12, 30)),
  TimeSlot(Hour(15, 0), Hour(19, 30)),
];
