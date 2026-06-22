import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart' show SpacerH, SpacerW;

class PatientdetailCard extends StatelessWidget {
  final BookingModel booking;
  const PatientdetailCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 119.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffF8F9FE),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        "https://img.freepik.com/premium-photo/natural-beauty-portrait-young-woman-soft-light_1351942-1320.jpg",
                        fit: BoxFit.cover,
                        width: 32.w,
                        height: 32.h,
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
                        text: (booking.type ?? "Consultation").toUpperCase(),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff2C78CF),
                      ),
                    ),
                  ],
                ),
                SpacerH(10.h),
                appText.primaryText(
                  text: booking.userDetails?.name ?? "Unknown Patient",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SpacerH(10.h),
                Row(
                  children: [
                    appText.primaryText(
                      text: booking.userDetails?.gender ?? "-",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SpacerW(12.w),
                    appText.primaryText(
                      text: "-",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8C8C8C),
                    ),
                    SpacerW(12.w),
                    appText.primaryText(
                      text: booking.userDetails?.age?.toString() ?? "-",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SpacerW(12.w),
                    appText.primaryText(
                      text: "year",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
    );
  }
}
