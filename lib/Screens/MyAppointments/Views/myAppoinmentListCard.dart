import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentDetailsScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class MyappointmentsListCard extends StatelessWidget {
  final BookingModel booking;

  const MyappointmentsListCard({
    super.key,
    required this.booking,
  });
  @override
Widget build(BuildContext context) {
  String formattedDate = "";

  if (booking.appointmentDate != null &&
      booking.appointmentDate!.isNotEmpty) {
    try {
      formattedDate = DateFormat(
        "dd EEE MMM",
      ).format(DateTime.parse(booking.appointmentDate!));
    } catch (_) {
      formattedDate = booking.appointmentDate!;
    }
  }

  return FadeInRight(
    child: InkWell(
      onTap: () {
        Get.to(
          () => AppointmentDetailScreen(
            booking: booking,
          ),
          transition: Transition.rightToLeft,
        );
      },
      child: Container(
        width: 361.w,
        height: 142.h,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xffF8F9FE),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          booking.profilePicture ??
                              "https://img.freepik.com/premium-photo/natural-beauty-portrait-young-woman-soft-light_1351942-1320.jpg",
                          fit: BoxFit.cover,
                          width: 32.w,
                          height: 32.h,
                          errorBuilder: (_, __, ___) => Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 18,
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
                          color: const Color(0xffBFD9F7),
                        ),
                        child: appText.primaryText(
                          text: (booking.type ?? "")
                              .toUpperCase(),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff2C78CF),
                        ),
                      ),
                    ],
                  ),
                  SpacerH(10.h),
                  appText.primaryText(
                    text: booking.userDetails?.name ?? "Unknown Patient",
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
                        text: booking.timeSlot ?? "--",
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
                        text: formattedDate,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff8C8C8C),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
}}