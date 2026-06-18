import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/AddBankScreen/AddBankScreen.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/Screens/WithdrawScreen/WithdrawScreen.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class EarningQuickActionCard extends StatelessWidget {
  const EarningQuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.h,
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appText.primaryText(
            text: "Quick Action",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121).withOpacity(.7),
          ),
          SpacerH(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    () => AddBankScreen(),
                    transition: Transition.downToUp,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Color(0xFF79747E)),
                  ),
                  height: 44.h,
                  width: 166.5.w,
                  child: appText.primaryText(
                    text: "Add Bank Account",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF424A53),
                  ),
                ),
              ),
              SpacerW(10.w),
              InkWell(
                onTap: () {
                  Get.to(
                    () => Withdrawscreen(),
                    transition: Transition.downToUp,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFF347D73),
                  ),
                  height: 44.h,
                  width: 166.5.w,
                  child: appText.primaryText(
                    text: "Withdraw Now",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEFEFEF),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
