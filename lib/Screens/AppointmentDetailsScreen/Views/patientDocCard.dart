import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentResultView.dart';
import 'package:zodo_dr/Utils/ImagesList.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';


class PatientDocCard extends StatelessWidget {
  String title;

  PatientDocCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      width: 360.w,
      //  height: 47.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded),
          SpacerW(6.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText.primaryText(
                  text: title, fontWeight: FontWeight.w600, fontSize: 14.sp),
              SpacerH(12.h),
              _docItem('ECG'),
              SpacerH(7.h),
              _docItem("Pressure Report"),
              SpacerH(7.h),
              _docItem("ECG"),
              SpacerH(7.h),
              _docItem("XRAY Result")
            ],
          ))
        ],
      ),
    );
  }
}

Widget _docItem(String title) {
  return Container(
    child: Row(
      children: [
        Image.asset(
          img.pdfImage,
          width: 25.w,
        ),
        SpacerW(5.w),
        appText.primaryText(
            text: title,
            fontWeight: FontWeight.w500,
            color: Color(0xff8C8C8C),
            fontSize: 13.sp),
        Spacer(),
        InkWell(
          onTap: () {
            Get.to(() => AppointmentResultView(),
                transition: Transition.downToUp);
          },
          child: appText.primaryText(
              text: "View",
              fontWeight: FontWeight.w600,
              color: Color(0xff3185E6),
              fontSize: 13.sp),
        )
      ],
    ),
  );
}
