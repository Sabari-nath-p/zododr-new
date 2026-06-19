import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';


class SCTimeView extends StatelessWidget {
  SCTimeView({super.key});

  List dayList = ["Morning", "Afternoon", "Evening"];

  List timeSlot = ["10", "15", "20", "30", "45", "60"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393.w,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      child: GetBuilder<CSController>(builder: (CSController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText.primaryText(
                text: "Select Slots",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
            SpacerH(16.h),
            Wrap(
              runSpacing: 15.w,
              spacing: 15.w,
              children: [
                for (var data in timeSlot)
                  InkWell(
                    onTap: () {
                      CSController.selectedTimeSlot = data;
                      CSController.update();
                    },
                    child: _menuItem(data + " mins",
                        selected: CSController.selectedTimeSlot == data),
                  )
              ],
            ),
            SpacerH(25.h),
            appText.primaryText(
                text: "Select Section",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
            SpacerH(16.h),
            Wrap(
              runSpacing: 15.w,
              spacing: 15.w,
              children: [
                for (var data in dayList)
                  InkWell(
                      onTap: () {
                        CSController.selectedSession = data;
                        CSController.update();
                      },
                      child:
                          _menuItem(data, selected: CSController.selectedSession == data))
              ],
            ),
            SpacerH(25.h),
            appText.primaryText(
                text: "Select Time",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
            SpacerH(16.h),
            Wrap(
              runSpacing: 15.w,
              spacing: 15.w,
              children: [
                for (var data in CSController.generateTimeSlots(
                    int.parse(CSController.selectedTimeSlot),
                    CSController.sessionModel[CSController.selectedSession]![0],
                    CSController.sessionModel[CSController.selectedSession]![1]))
                  InkWell(
                      onTap: () {
                        if (CSController.selectedTimes.contains(data)) {
                          CSController.selectedTimes.remove(data);
                        } else {
                          CSController.selectedTimes.add(data);
                        }
                        CSController.update();
                      },
                      child: _menuItem(data,
                          selected: CSController.selectedTimes.contains(data)))
              ],
            ),
            SpacerH(80.h)
          ],
        );
      }),
    );
  }
}

Widget _menuItem(String namme, {bool selected = false}) {
  return Container(
    width: 105.w,
    alignment: Alignment.center,
    height: 41.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: (selected) ? AppColors.PrimaryColor : Color(0xffF9FAFB)),
    child: appText.primaryText(
        text: "$namme",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: (selected) ? Colors.white : null),
  );
}