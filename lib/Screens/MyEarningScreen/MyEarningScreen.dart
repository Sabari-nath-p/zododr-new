import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Controller/Settlementcontroller.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningAnalyticsCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningBankCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningInfoCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningPaymentCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/EarningQuickActionCard.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class MyEarningScreen extends StatelessWidget {
  const MyEarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Settlementcontroller());
    final utils = Get.find<Utilscontroller>();

    return Scaffold(
      body: Column(
        children: [
          MyEarningAppBar(name: "My Earnings"),
          SpacerH(51.h),
          Expanded(
            child: Obx(() {
              if (controller.isWalletLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
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
                      text: "₹ ${controller.balanceAmount.value}",
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                    SpacerH(12.h),
                    EarningAnalyticsCard(
                      totalEarnings: controller.totalAmount.value,
                      lastSettlement: controller.lastSettlement.value,
                    ),
                    SpacerH(25.h),
                    if (controller.hasBankDetails.value)
                      EarningBankCard(
                        bankName: utils.user?.bankDetails?.bankName ?? "",
                        maskedAccountNumber: _maskAccount(
                          utils.user?.bankDetails?.accountNumber,
                        ),
                      ),
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

                    // ---------------------------------------------------
                    // PAYMENT HISTORY — real settlements data from API
                    // ---------------------------------------------------
                    Obx(() {
                      if (controller.isSettlementsLoading.value &&
                          controller.settlementsList.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (controller.settlementsList.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: appText.primaryText(
                            text: "No payment history yet",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121).withOpacity(.5),
                          ),
                        );
                      }

                      final bool canLoadMore =
                          controller.currentPage.value < controller.totalPages.value;

                      return Column(
                        children: [
                          ...controller.settlementsList.map((item) {
                            return EarningPaymentCard(
                              amount: item["amount"]?.toString() ?? "0",
                              paymentMethod:
                                  item["payment_method"]?.toString() ?? "",
                              status: item["status"]?.toString() ?? "",
                              date: _formatDate(
                                item["request_date"]?.toString(),
                              ),
                            );
                          }),
                          if (canLoadMore)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: TextButton(
                                onPressed: () =>
                                    controller.loadMoreSettlements(),
                                child: Text("Load More"),
                              ),
                            ),
                        ],
                      );
                    }),

                    SpacerH(20.h),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _maskAccount(String? accountNumber) {
    if (accountNumber == null || accountNumber.length < 4) {
      return "**** **** ****";
    }
    final last4 = accountNumber.substring(accountNumber.length - 4);
    return "**** **** **** $last4";
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return "";
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
        "JUL", "AUG", "SEP", "OCT", "NOV", "DEC",
      ];
      return "${date.day}TH ${months[date.month - 1]}";
    } catch (e) {
      return "";
    }
  }
}