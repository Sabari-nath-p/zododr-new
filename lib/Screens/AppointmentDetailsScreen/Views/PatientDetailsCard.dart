import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart' show SpacerH, SpacerW;


class PatientdetailCard extends StatelessWidget {
  const PatientdetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 119.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(0xffF8F9FE)),
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
                          color: Color(0xffBFD9F7)),
                      child: appText.primaryText(
                          text: "New Consultation".toUpperCase(),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2C78CF)),
                    )
                  ],
                ),
                SpacerH(10.h),
                appText.primaryText(
                    text: "Kevin Sam Mathew",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                SpacerH(10.h),
                Row(
                  children: [
                    appText.primaryText(
                      text: "F",
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
                      text: "24",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    appText.primaryText(
                      text: " yr",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8C8C8C),
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
                      text: "178",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    appText.primaryText(
                      text: " cm",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8C8C8C),
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
                      text: "55",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    appText.primaryText(
                      text: "kg",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8C8C8C),
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
          )
        ],
      ),
    );
  }
}
