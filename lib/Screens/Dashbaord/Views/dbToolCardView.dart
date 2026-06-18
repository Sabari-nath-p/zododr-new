import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:zodo_dr/Utils/appText.dart';

class dbToolCardView extends StatelessWidget {
  String title;
  String image;
  String subtext;
  dbToolCardView({
    super.key,
    required this.title,
    required this.image,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      height: 146.h,
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.4)),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10.h,
            left: 0,
            right: 0,
            child: appText.primaryText(
              text: title,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
          Positioned(
            top: 30.h,
            child: appText.primaryText(
              text: subtext,
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Image.asset(image, width: 61.w),
          ),
        ],
      ),
    );
  }
}
