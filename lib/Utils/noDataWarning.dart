import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoDataWarning extends StatelessWidget {
  String title;
  String body;
  double margin;
  bool isLottie;
  NoDataWarning({
    super.key,
    this.margin = 0,
    this.title = "No Doctor Found",
    this.isLottie = false,
    this.body = "We couldn't find any matching doctors",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin),
      width: 390.w,
      height: 500.h,
      child: Column(
        children: [
          if (!isLottie) Image.asset("Assets/Images/warning.png", width: 200.w),
          if (isLottie)
            LottieBuilder.asset(
              "Assets/Animations/hospitalwarning.json",
              width: 120.w,
            ),
          SizedBox(height: 10.h),
          Text(
            "$title",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5.h),
          Text(
            "$body",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
