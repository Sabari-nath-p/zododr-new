import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/utils/ImagesList.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class EarningPaymentCard extends StatelessWidget {
  EarningPaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, left: 25.w, right: 25.w),
      width: 343.h,
      height: 39.h,
      child: Row(
        children: [
          Image.asset(img.growUP, width: 24, height: 24),
          //Image.asset(img.pendingClock,width: 24,height: 24,),
          SpacerW(25.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText.primaryText(
                text: "₹223",
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
              appText.primaryText(
                text: "Online Consultation",
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF212121).withOpacity(.5),
              ),
            ],
          ),
          Spacer(),
          appText.primaryText(
            text: "24TH NOV",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ],
      ),
    );
  }
}
