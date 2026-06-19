import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentDetailsScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Controller/HomeController.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class HmupcommingadptCard extends StatelessWidget {
  HmupcommingadptCard({super.key});
  Homecontroller ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: appText.primaryText(
                  text: "Upcomming Appointments",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  // Get.to(() => MyAppointmentScreen(),
                  //     transition: Transition.rightToLeft);
                },
                child: appText.primaryText(
                  text: "See all",
                  color: Color(0xff3185E6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SpacerW(16.w),
            ],
          ),
          SpacerH(25.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [for (var data in ctrl.bookings) _UpCommingCard(data)],
            ),
          ),
          SpacerH(20),
        ],
      ),
    );
  }
}

Widget _UpCommingCard(BookingModel booking) {
  return FadeInRight(
    child: InkWell(
      onTap: () {
        Get.to(
          () => AppointmentDetailScreen(),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        width: 202.w,
        height: 200.h,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffF8F9FE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    booking.profilePicture ?? "",
                    fit: BoxFit.cover,
                    width: 32.w,
                    height: 32.h,
                    errorBuilder:
                        (context, error, stackTrace) => Opacity(
                          opacity: .7,
                          child: Image.asset(
                            'Assets/Images/zodo_icon_only.png',
                            fit: BoxFit.contain,
                            width: 32.w,
                            height: 32.w,
                          ),
                        ),
                  ),
                ),
                SpacerW(10.w),
                Container(
                  width: 126.w,
                  alignment: Alignment.center,
                  height: 23.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffBFD9F7),
                  ),
                  child: appText.primaryText(
                    text: "New Consultation".toUpperCase(),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2C78CF),
                  ),
                ),
              ],
            ),
            SpacerH(12.h),
            appText.primaryText(
              text: booking.userDetails!.name!,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            SpacerH(10.h),
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 18.sp,
                  color: Color(0xff8C8C8C),
                ),
                SpacerW(6.w),
                appText.primaryText(
                  text: DateFormat(
                    "hh:mm a",
                  ).format(DateFormat.Hms().parse(booking.timeSlot ?? "")),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff8C8C8C),
                ),
              ],
            ),
            SpacerH(10.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 18.sp,
                  color: Color(0xff8C8C8C),
                ),
                SpacerW(6.w),
                appText.primaryText(
                  text: DateFormat(
                    "dd EEE MMM",
                  ).format(DateTime.parse(booking.appointmentDate!)),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff8C8C8C),
                ),
              ],
            ),
            SpacerH(12.h),
            CircleAvatar(
              radius: 22.w,
              backgroundColor: Color(0xffE0EDFB),
              child: Icon(
                Icons.video_camera_back_rounded,
                color: Color(0xff276AB8),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
