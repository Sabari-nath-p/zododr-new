import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class EarningAnalyticsCard extends StatelessWidget {
  final String totalEarnings;
  final String lastSettlement;

  EarningAnalyticsCard({
    super.key,
    required this.totalEarnings,
    required this.lastSettlement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      width: 343.w,
      height: 66.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF0F2F7),
      ),
      child: Row(
        children: [
          Column(
            children: [
              appText.primaryText(
                text: "Total Earnings",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121).withOpacity(.7),
              ),
              SpacerH(8.h),
              appText.primaryText(
                text: "₹ $totalEarnings",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF029C5C),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              appText.primaryText(
                text: "Last Settlement",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121).withOpacity(.7),
              ),
              SpacerH(8.h),
              appText.primaryText(
                text: "₹ $lastSettlement",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
