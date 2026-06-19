import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Utils/Colors.dart';

class SCHorizontalCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const SCHorizontalCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
     final DateTime today = DateTime.now();

// start 2 years back from current month
final DateTime startDate = DateTime(today.year - 2, today.month, 1);

// total ~4 years range (adjust if needed)
final int totalDays = 365 * 4;

final dates = List.generate(
  totalDays,
  (index) => startDate.add(Duration(days: index)),
);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.PrimaryColor,
                  size: 15.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  DateFormat("MMMM yyyy").format(selectedDate),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          SizedBox(
            height: 60.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final date = dates[index];

                final isSelected =
                    selectedDate.day == date.day &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;

                return GestureDetector(
                  onTap: () {
                    onDateSelected(date);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 45.w,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.PrimaryColor
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color:
                            isSelected
                                ? AppColors.PrimaryColor
                                : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("EEE").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          "${date.day}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        Text(
                          DateFormat("MMM").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white70 : Colors.grey,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 8.h),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.PrimaryColor.withOpacity(.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_available,
                  color: AppColors.PrimaryColor,
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Selected Date : ${DateFormat("dd MMM yyyy").format(selectedDate)}",
                    style: TextStyle(
                      color: AppColors.PrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
