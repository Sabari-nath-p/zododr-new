import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Utils/appText.dart';


class MyAppointmentCalender extends StatelessWidget {
  MyAppointmentCalender({super.key});

  HorizontalWeekCalenderController calenderController =
      HorizontalWeekCalenderController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 75.h,
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffB3B3B3))),
            child: InkWell(
                onTap: () {
                  calenderController.jumpPre();
                },
                child: Icon(Icons.arrow_back_ios_new)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: HorizontalWeekCalendar(
              controller: calenderController,
              minDate: DateTime.now().subtract(Duration(days: 100)),
              maxDate: DateTime.now().add(Duration(days: 10)),
              initialDate: DateTime.now(),
              activeTextColor: Color(0xffFF7017),
              inactiveTextColor: Color(0xffB3B3B3),
              customItem: (date, selected) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appText.primaryText(
                          text: DateFormat("EEE").format(date),
                          fontSize: 12.sp,
                          color: selected ? Color(0xffFF7017) : null,
                          fontWeight: FontWeight.w400),
                      appText.primaryText(
                          text: DateFormat("dd").format(date),
                          fontSize: 18.sp,
                          color: selected ? Color(0xffFF7017) : null,
                          fontWeight: FontWeight.w600),
                      if (selected)
                        Container(
                          width: 100,
                          height: 2.5.h,
                          decoration: BoxDecoration(
                              // gradient: LinearGradient(colors: [
                              //   Color(0xffFF7017),
                              //   Color(0xffFEC20D)
                              // ]),
                              color: selected ? Color(0xffFF7017) : null,
                              borderRadius: BorderRadius.circular(10)),
                        )
                    ],
                  ),
                );
              },

              inactiveBackgroundColor: Colors.transparent, //Color(0xffB3B3B3),
              activeBackgroundColor: Colors.transparent, //Color(0xffFF7017),
              showTopNavbar: false,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 32.w,
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffB3B3B3))),
            child: InkWell(
                onTap: () {
                  calenderController.jumpNext();
                },
                child: RotatedBox(
                    quarterTurns: 2, child: Icon(Icons.arrow_back_ios_new))),
          ),
        ],
      ),
    );
  }
}