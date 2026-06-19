import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/AvailabilityCard.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/EmptySlotWidget.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/SCHorizontalCalendar.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/SCTimeView.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/SlotCreateAppBar.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/TimeSlotDialogue.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/WeeklySlotScreen.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/appButtons.dart';

class CreateSlotScreen extends StatefulWidget {
  CreateSlotScreen({super.key});

  final CreateSlotController controller = Get.put(CreateSlotController());

  @override
  State<CreateSlotScreen> createState() => _CreateSlotScreenState();
}

class _CreateSlotScreenState extends State<CreateSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      body: Column(
        children: [
          SlotCreateAppBar(
            name: "Appointments Schedule",
            onCalendarTap: () {
              Get.to(() => WeeklySlotScreen());
            },
          ),

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
                          /// ================= DATE =================
                          Text(
                            "Select Date",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 15.h),

                          SCHorizontalCalendar(
                            selectedDate: controller.selectedDate,
                            onDateSelected: (date) {
                              controller.changeDate(date);
                            },
                          ),

                          SizedBox(height: 20.h),

                          /// ================= TITLE =================
                          Row(
                            children: [
                              Text(
                                "Set Your Availability",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),

                          SizedBox(height: 15.h),

                          if (controller.isLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          else if (controller.dateAvailabilities.isEmpty)
                            const EmptySlotWidget()
                          else
                            const SCTimeView(),
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
