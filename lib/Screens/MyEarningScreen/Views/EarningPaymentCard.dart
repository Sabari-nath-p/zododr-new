import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class EarningPaymentCard extends StatelessWidget {
  final String amount;
  final String paymentMethod;
  final String status;
  final String date;

  const EarningPaymentCard({
    super.key,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, left: 25.w, right: 25.w),
      width: 343.h,
      height: 39.h,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText.primaryText(
                text: "₹$amount",
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
              appText.primaryText(
                text: "$paymentMethod • $status",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121).withOpacity(.5),
              ),
            ],
          ),
          Spacer(),
          appText.primaryText(
            text: date,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ],
      ),
    );
  }
}
