import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Utils/Colors.dart';


Widget buildDayCard({
  required BuildContext context,
  required String day,
  required List<Widget> timeSlots,
  VoidCallback? onAdd,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        /// Header
        Container(
          padding:  EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
             color:  AppColors.PrimaryColor.withOpacity(.1),
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  day,
                  style:  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),
                ),
              ),

              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(30.r),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.add_circle_outline,
                    color:Colors.black,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Slots
        if (timeSlots.isEmpty)
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              "No time slots available",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          )
        else
          Column(children: timeSlots),
      ],
    ),
  );
}

Widget buildTimeSlotTile({
  required String startTime,
  required String endTime,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
}) {
  return Container(
    padding:  EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 10.h,
    ),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
    ),
    child: Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          color: Color(0xff1CA7EC),
          size: 18.sp,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            "$startTime - $endTime",
            style:  TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.edit_rounded,
              size: 18.sp,
              color: Colors.blue.shade600,
            ),
          ),
        ),

        const SizedBox(width: 6),

        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: Colors.red.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}