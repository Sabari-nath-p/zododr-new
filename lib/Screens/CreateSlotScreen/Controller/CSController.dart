import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

class CSController extends GetxController {
  List<DateTime> selectedDate = [];
  String selectedTimeSlot = "30";
  String selectedSession = "Morning";
  List<String> selectedTimes = [];

  List<String> generateTimeSlots(
      int timeSlot, String fromTime, String endTime) {
    // Define the time format
    final timeFormat = DateFormat("hh:mm a");

    // Parse the input times
    final start = DateFormat("HH:mm").parse(fromTime);
    final end = DateFormat("HH:mm").parse(endTime);

    // Check if the start time is before the end time
    if (start.isAfter(end)) {
      throw ArgumentError("fromTime must be earlier than endTime");
    }

    // Generate time slots
    List<String> timeSlots = [];
    var current = start;

    while (current.isBefore(end)) {
      final next = current.add(Duration(minutes: timeSlot));
      if (next.isAfter(end)) break;
      timeSlots.add("${timeFormat.format(current)}");
      current = next;
    }

    return timeSlots;
  }

  var sessionModel = {
    "Morning": ["08:00", "12:00"],
    "Afternoon": ["12:00", "16:00"],
    "Evening": ["16:00", "22:00"]
  };
}