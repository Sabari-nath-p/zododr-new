import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningAnalyticsCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningBankCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningInfoCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningPaymentCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningQuickActionCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class MyEarningScreen extends StatelessWidget {
  const MyEarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyEarningAppBar(name: "My Earnings"),
          SpacerH(51.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appText.primaryText(
                    text: "Main Balance",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121).withOpacity(.5),
                  ),
                  SpacerH(2.h),
                  appText.primaryText(
                    text: "₹ 2,8754",
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                  SpacerH(12.h),
                  EarningAnalyticsCard(),
                  SpacerH(25.h),
                  EarningBankCard(),
                  SpacerH(12.h),
                  EarningInfoCard(),
                  SpacerH(25.h),
                  EarningQuickActionCard(),
                  SpacerH(25.h),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    child: appText.primaryText(
                      text: "Payment History",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121).withOpacity(.7),
                    ),
                  ),
                  for (int i = 0; i < 10; i++) EarningPaymentCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
