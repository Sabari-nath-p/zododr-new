import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Utils/appText.dart';

class MyAppointmentCalender extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const MyAppointmentCalender({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<MyAppointmentCalender> createState() =>
      _MyAppointmentCalenderState();
}

class _MyAppointmentCalenderState
    extends State<MyAppointmentCalender> {
  final HorizontalWeekCalenderController calenderController =
      HorizontalWeekCalenderController();

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 361.w,
      height: 75.h,
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffB3B3B3),
              ),
            ),
            child: InkWell(
              onTap: () => calenderController.jumpPre(),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: HorizontalWeekCalendar(
              controller: calenderController,
              minDate: DateTime.now().subtract(
                const Duration(days: 100),
              ),
              maxDate: DateTime.now().add(
                const Duration(days: 10),
              ),
              initialDate: widget.selectedDate,

              activeTextColor: Colors.transparent,
              inactiveTextColor: Colors.transparent,
              activeBackgroundColor: Colors.transparent,
              inactiveBackgroundColor: Colors.transparent,
              showTopNavbar: false,

              onDateChange: (date) {
                widget.onDateSelected(date);
              },

              customItem: (date, selected) {
                final isToday = isSameDay(
                  date,
                  DateTime.now(),
                );

                final isSelected = isSameDay(
                  date,
                  widget.selectedDate,
                );

                Color textColor = Colors.black;

                if (isToday) {
                  textColor = const Color(0xffFF7017);
                }

                if (isSelected && !isToday) {
                  textColor = const Color(0xff276AB8);
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appText.primaryText(
                      text: DateFormat("EEE").format(date),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                    SizedBox(height: 2.h),
                    appText.primaryText(
                      text: DateFormat("dd").format(date),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    SizedBox(height: 4.h),
                    if (isSelected)
                      Container(
                        width: 22.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: isToday
                              ? const Color(0xffFF7017)
                              : const Color(0xff276AB8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          Container(
            width: 32.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffB3B3B3),
              ),
            ),
            child: InkWell(
              onTap: () => calenderController.jumpNext(),
              child: const RotatedBox(
                quarterTurns: 2,
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
        ],
      ),
    );
  }
}