import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class EarningInfoCard extends StatelessWidget {
  const EarningInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 343.w,
      height: 66.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffE1EFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appText.primaryText(
            text: "Details",
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121).withOpacity(.7),
          ),
          SpacerH(8.h),
          appText.primaryText(
            text: "The minimum amount 1000 required to transfer",
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF212121).withOpacity(.7),
          ),
        ],
      ),
    );
  }
}
