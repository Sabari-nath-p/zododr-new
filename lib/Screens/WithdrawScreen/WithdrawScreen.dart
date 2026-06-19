import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Controller/Settlementcontroller.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningAnalyticsCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningInfoCard.dart';
import 'package:zodo_dr/utils/appButtons.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/appTextField.dart';
import 'package:zodo_dr/utils/utils.dart';

import '../MyEarningScreen/Views/MyEarningAppBar.dart';

class Withdrawscreen extends StatelessWidget {
  Withdrawscreen({super.key});

  final Settlementcontroller controller = Get.find<Settlementcontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyEarningAppBar(name: "Withdraw Now"),
          SpacerH(51.h),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 25.w,
                  left: 25.w,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        appText.primaryText(
                          text: "Main Balance",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121).withOpacity(.7),
                        ),
                        SpacerH(2.h),
                        Obx(
                          () => appText.primaryText(
                            text: "₹ ${controller.balanceAmount.value}",
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF212121),
                          ),
                        ),
                        SpacerH(12.h),
                        Obx(
                          () => EarningAnalyticsCard(
                            totalEarnings: controller.totalAmount.value,
                            lastSettlement: controller.lastSettlement.value,
                          ),
                        ),
                        SpacerH(31.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appText.primaryText(
                              text: "Enter Amount",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              prefixText: "₹",
                              controller: controller.withdrawAmountController,
                              keyType: TextInputType.number,
                            ),
                            SpacerH(8.h),
                            appText.primaryText(
                              text:
                                  "Amount will be credited to your account within one business day.",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFBEA216),
                            ),
                          ],
                        ),
                        SpacerH(30.h),
                        EarningInfoCard(),
                        SpacerH(100.h),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 25.w,
                  left: 25.w,
                  child: Obx(
                    () => appButton.PrimaryButton(
                      name: "Proceed",
                      isLoading: controller.isWithdrawSubmitting.value,
                      onClick: () {
                        if (!controller.isWithdrawSubmitting.value) {
                          controller.createSettlement();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
