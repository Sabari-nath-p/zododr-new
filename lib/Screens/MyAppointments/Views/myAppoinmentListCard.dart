import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentDetailsScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';


class MyappointmentsListCard extends StatelessWidget {
  
  const MyappointmentsListCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: InkWell(
        onTap: () {
          Get.to(() => AppointmentDetailScreen( ),
              transition: Transition.rightToLeft);
        },
        child: Container(
            width: 361.w,
            height: 142.h,
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xffF8F9FE)),
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
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
                            text: "02:00 PM",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8C8C8C),
                          )
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
                            text: "04 Wed Aug",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8C8C8C),
                          )
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
            )),
      ),
    );
  }
}