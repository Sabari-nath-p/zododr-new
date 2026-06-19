import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/AvailabilityCard.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/SCTimeView.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/TimeSlotDialogue.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/SlotCreateAppBar.dart';

class WeeklySlotScreen extends StatelessWidget {
  WeeklySlotScreen({super.key});

  final CreateSlotController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      body: Column(
        children: [
          SlotCreateAppBar(name: "Doctor Availability"),

          Expanded(
            child: GetBuilder<CreateSlotController>(
              builder: (controller) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 110.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE
                          Text(
                            "Set Your Weekly Availability",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 35.h),

                          /// WEEK LIST UI (reuse your existing data)
                          Column(
                            children: controller.weekList.map((week) {
                              final slots =
                                  controller.getWeekSlots(week.id);

                              return buildDayCard(
                                context: context,
                                day: week.name ?? "Week",

                                onAdd: () {
                                  showTimeSlotDialog(
                                    context,
                                    mode: SlotMode.week,
                                    weekId: week.id,
                                    weekName: week.name,
                                  );
                                },

                                timeSlots: List.generate(slots.length,
                                    (index) {
                                  final slot = slots[index];

                                  return buildTimeSlotTile(
                                    startTime: slot["startTime"] ?? "--",
                                    endTime: slot["endTime"] ?? "--",

                                    onEdit: () {
                                      showTimeSlotDialog(
                                        context,
                                        mode: SlotMode.week,
                                        weekId: week.id,
                                      );
                                    },

                                    onDelete: () {
                                      showDeleteDialog(
                                        context,
                                        onDelete: () {
                                          controller.deleteAvailability(
                                            availabilityId:
                                                slot["id"].toString(),
                                            weekId: week.id,
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}