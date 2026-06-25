import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Model/TimeSlotModel.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Model/WeakModel.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';

class CreateSlotController extends GetxController {
  static CreateSlotController get to => Get.find();

  bool isLoading = false;
  bool isCreating = false;

  String selectedType = "date";

  DateTime selectedDate = DateTime.now();

  String? doctorId;

  List<WeekModel> weekList = [];

  /// DATE SLOTS
  List<dynamic> dateAvailabilities = [];

  /// WEEK SLOTS (KEY FIX)
  Map<String, List<dynamic>> weekSlots = {};

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  bool notAvailable = false;

  List<TimeSlotModel> timeSlots = [];
  List get offDaySlots =>
    dateAvailabilities.where((e) => e["not_available"] == true).toList();

List get availableSlots =>
    dateAvailabilities.where((e) => e["not_available"] != true).toList();

  @override
  void onInit() {
    super.onInit();
    loadDoctorId();
  }

  Future<void> loadDoctorId() async {
    final pref = await SharedPreferences.getInstance();
    doctorId = pref.getString("DOCTOR_ID");
    if (doctorId == null || doctorId!.isEmpty) {
      log("Doctor ID not found");
      return;
    }
    update();
    await getWeeks();
    await fetchDateAvailabilities(doctorId: doctorId!);
  }


  
  void changeDate(DateTime value) {
    selectedDate = value;
    update();
    fetchDateAvailabilities(doctorId: doctorId!);
  }


  void changeNotAvailable(bool value) {
    notAvailable = value;
    update();
  }

  Future<void> pickStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      startTime = picked;
      update();
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          endTime ??
          TimeOfDay(
            hour: (TimeOfDay.now().hour + 1) % 24,
            minute: TimeOfDay.now().minute,
          ),
    );

    if (picked != null) {
      endTime = picked;
      update();
    }
  }

  
  Future<void> loadAllWeekSlots() async {
    for (final week in weekList) {
      await fetchWeekAvailabilitiesForWeek(week.id);
    }
  }

  Future<void> fetchWeekAvailabilitiesForWeek(String weekId) async {
    await ApiService.request(
      endpoint: "availabilities/doctors/$doctorId/week?week_id=$weekId",
      method: Api.GET,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          final List data = response.data["data"] ?? [];

          List slots = [];

          if (data.isNotEmpty) {
            slots = data.first["availabilities"] ?? [];
          }

          weekSlots[weekId] = slots;
        }

        update();
      },
      onError: (e) {
        log(e.toString());
      },
    );
  }

  Future<void> getWeeks() async {
    isLoading = true;
    update();

    await ApiService.request(
      endpoint: "weeks",
      method: Api.GET,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          final List data = response.data;

          weekList = data.map((e) => WeekModel.fromJson(e)).toList();

          /// LOAD ALL WEEK SLOTS (IMPORTANT FIX)
          loadAllWeekSlots();
        }

        update();
      },
      onError: (e) {
        log(e.toString());
      },
    );

    isLoading = false;
    update();
  }

  Future<void> fetchDateAvailabilities({required String doctorId}) async {
    isLoading = true;
    update();

    final date = DateFormat("yyyy-MM-dd").format(selectedDate);

    await ApiService.request(
      endpoint: "availabilities/doctors/$doctorId/date?date=$date",
      method: Api.GET,
      onSuccess: (response) {
        if (response.statusCode == 200) {
          dateAvailabilities = response.data["data"] ?? [];
        } else {
          dateAvailabilities = [];
        }

        update();
      },
      onError: (e) {
        log(e.toString());
      },
    );

    isLoading = false;
    update();
  }

  //--------------------------------------------------------
  /// CREATE SLOT
  //--------------------------------------------------------
  Future<void> createAvailability({
    required String doctorId,
    DateTime? date,
    String? weekId,
  }) async {
    if (!notAvailable) {
      if (startTime == null || endTime == null) {
        Customalerts.errorAlert(
          title: "Time Required",
          body: "Select start & end time",
        );
        return;
      }
    }

    isCreating = true;
    update();

    final bool isWeek = weekId != null;

    final Map<String, dynamic> body = {
      "doctor_id": doctorId,
      "type": isWeek ? "week" : "date",
      "startTime": notAvailable ? null : formatTime(startTime),
      "endTime": notAvailable ? null : formatTime(endTime),
      "not_available": notAvailable,
    };

    // ✅ DATE MODE
    if (!isWeek) {
      body["date"] = DateFormat("yyyy-MM-dd").format(date ?? selectedDate);
    }

    // ✅ WEEK MODE
    if (isWeek) {
      body["week_id"] = weekId;
    }

    log("REQUEST BODY => $body");

    await ApiService.request(
      endpoint: "availabilities",
      method: Api.POST,
      body: body,
      onSuccess: (response) {
        Get.snackbar("Success", response.data["message"]);

        startTime = null;
        endTime = null;
        notAvailable = false;

        update();

        // ✅ refresh correctly
        if (isWeek) {
          fetchWeekAvailabilitiesForWeek(weekId!);
        } else {
          fetchDateAvailabilities(doctorId: doctorId);
        }
      },
      onError: (e) {
        log(e.toString());
      },
    );

    isCreating = false;
    update();
  }

  //--------------------------------------------------------
  /// DELETE AVAILABILITY
  //--------------------------------------------------------
  Future<void> deleteAvailability({
    required String availabilityId,
    String? weekId,
  }) async {
    await ApiService.request(
      endpoint: "availabilities/$availabilityId",
      method: Api.DELETE,
      onSuccess: (response) {
        Get.snackbar("Success", response.data["message"]);

        final isWeek = weekId != null;

        if (isWeek) {
          // refresh only that week
          fetchWeekAvailabilitiesForWeek(weekId);
        } else {
          // refresh selected date
          fetchDateAvailabilities(doctorId: doctorId!);
        }
      },
      onError: (e) {
        log(e.toString());
      },
    );
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "";

    final now = DateTime.now();

    final date = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    return DateFormat("HH:mm").format(date);
  }

  Future<void> updateAvailability({
    required String availabilityId,
    required String doctorId,
    DateTime? date,
    String? weekId,
  }) async {
    if (!notAvailable) {
      if (startTime == null || endTime == null) {
        Customalerts.errorAlert(
          title: "Time Required",
          body: "Select start & end time",
        );
        return;
      }
    }

    isCreating = true;
    update();

    final bool isWeek = weekId != null;

    final Map<String, dynamic> body = {
      "doctor_id": doctorId,
      "type": isWeek ? "week" : "date",
      "startTime": notAvailable ? null : formatTime(startTime),
      "endTime": notAvailable ? null : formatTime(endTime),
      "not_available": notAvailable,
    };

    // DATE MODE
    if (!isWeek) {
      body["date"] = DateFormat("yyyy-MM-dd").format(date ?? selectedDate);
    }

    // WEEK MODE
    if (isWeek) {
      body["week_id"] = weekId;
    }

    log("PATCH BODY => $body");

    await ApiService.request(
      endpoint: "availabilities/$availabilityId",
      method: Api.PATCH,
      body: body,
      onSuccess: (response) {
        Get.snackbar("Success", response.data["message"]);

        startTime = null;
        endTime = null;
        notAvailable = false;

        update();
        Get.back();

        // refresh UI
        if (isWeek) {
          fetchWeekAvailabilitiesForWeek(weekId!);
        } else {
          fetchDateAvailabilities(doctorId: doctorId);
        }
      },
      onError: (e) {
        log(e.toString());
      },
    );

    isCreating = false;
    update();
  }

  Future<void> fetchTimeSlots({required String doctorId}) async {
    isLoading = true;
    update();

    // ✅ clear old data first (important for UI switch)
    timeSlots = [];
    update();

    ApiService.request(
      endpoint: "time-slots/doctors/$doctorId",
      method: Api.GET,
      requiresAuth: true,
      onSuccess: (response) {
        try {
          final data = response.data['data'];

          if (data == null || data is! List || data.isEmpty) {
            timeSlots = [];
            log("No time slots found");
          } else {
            timeSlots =
                data
                    .map<TimeSlotModel>((e) => TimeSlotModel.fromJson(e))
                    .toList();

            log("Slots loaded: ${timeSlots.length}");
          }
        } catch (e) {
          log("Parsing error: $e");
          timeSlots = [];
        }

        isLoading = false;
        update();
      },
      onUnauthenticated: () {
        isLoading = false;
        timeSlots = [];
        update();
      },
      onNetworkError: (msg) {
        log(msg);
        isLoading = false;
        timeSlots = [];
        update();
      },
      onError: (e) {
        log("Error: $e");
        isLoading = false;
        timeSlots = [];
        update();
      },
    );
  }

  //--------------------------------------------------------
  /// WEEK MAP ACCESSOR
  //--------------------------------------------------------
  List<dynamic> getWeekSlots(String weekId) {
    return weekSlots[weekId] ?? [];
  }
}
