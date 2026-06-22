import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentDetailsScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Controller/HomeController.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class HmupcommingadptCard extends StatelessWidget {
  const HmupcommingadptCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
      builder: (ctrl) {
        return Container(
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: appText.primaryText(
                      text: "Upcoming Appointments",
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
                      color: const Color(0xff3185E6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SpacerW(16.w),
                ],
              ),

              SpacerH(25.h),

              if (ctrl.bookings.isEmpty)
                SizedBox(
                  height: 200.h,
                  child: Center(
                    child: appText.primaryText(
                      text: "No upcoming appointments",
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ctrl.bookings.isEmpty
    ? SizedBox(
        height: 200.h,
        child: Center(
          child: Text("No appointments today"),
        ),
      )
    : Row(
        children: [
          for (final booking in ctrl.bookings)
            _UpCommingCard(booking),
        ],
      ),
                ),

              SpacerH(20.h),
            ],
          ),
        );
      },
    );
  }
}

Widget _UpCommingCard(BookingModel booking) {
  return FadeInRight(
    child: InkWell(
      onTap: () {
        Get.to(
          () => AppointmentDetailScreen(booking: booking),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        width: 202.w,
        height: 200.h,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: const Color(0xffF8F9FE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.network(
                    booking.profilePicture ?? "",
                    width: 32.w,
                    height: 32.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Opacity(
                      opacity: .7,
                      child: Image.asset(
                        'Assets/Images/zodo_icon_only.png',
                        width: 32.w,
                        height: 32.w,
                      ),
                    ),
                  ),
                ),
                SpacerW(10.w),
                Container(
                  width: 126.w,
                  height: 23.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffBFD9F7),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: appText.primaryText(
                    text: "NEW CONSULTATION",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2C78CF),
                  ),
                ),
              ],
            ),

            SpacerH(12.h),

            appText.primaryText(
              text: booking.userDetails?.name ?? "Unknown",
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),

            SpacerH(10.h),

            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 18.sp,
                  color: const Color(0xff8C8C8C),
                ),
                SpacerW(6.w),
                appText.primaryText(
                  text: booking.timeSlot == null || booking.timeSlot!.isEmpty
                      ? "--"
                      : DateFormat("hh:mm a").format(
                          DateFormat("HH:mm:ss").parse(booking.timeSlot!),
                        ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff8C8C8C),
                ),
              ],
            ),

            SpacerH(10.h),

            Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 18.sp,
                  color: const Color(0xff8C8C8C),
                ),
                SpacerW(6.w),
                appText.primaryText(
                  text: booking.appointmentDate == null
                      ? "--"
                      : DateFormat("dd EEE MMM").format(
                          DateTime.parse(booking.appointmentDate!),
                        ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff8C8C8C),
                ),
              ],
            ),

            SpacerH(12.h),

            CircleAvatar(
              radius: 22.w,
              backgroundColor: const Color(0xffE0EDFB),
              child: const Icon(
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