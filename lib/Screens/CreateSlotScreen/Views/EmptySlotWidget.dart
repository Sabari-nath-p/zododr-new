import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/TimeSlotDialogue.dart';

class EmptySlotWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptySlotWidget({
    super.key,
    this.title = "No time slot created",
    this.subtitle = "Tap + Add Slot to create your first availability",
    this.icon = Icons.calendar_month_outlined,
  });

  void _openAddSlotDialog(BuildContext context) {
    final controller = CreateSlotController.to;

    showTimeSlotDialog(
      context,
      mode: SlotMode.date,
      date: controller.selectedDate,
      title:
          "Add Slot - ${DateFormat("dd MMM yyyy").format(controller.selectedDate)}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),

            /// ICON (CLICKABLE)
            GestureDetector(
              onTap: () => _openAddSlotDialog(context),
              child: Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 45.sp, color: Colors.grey),
              ),
            ),

            SizedBox(height: 20.h),

            /// TITLE
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 8.h),

            /// SUBTITLE
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),

            SizedBox(height: 25.h),

            /// BUTTON
            ElevatedButton.icon(
              onPressed: () => _openAddSlotDialog(context),
              icon: Icon(Icons.add, size: 18.sp, color: Colors.white),
              label: Text(
                "Add Slot",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
