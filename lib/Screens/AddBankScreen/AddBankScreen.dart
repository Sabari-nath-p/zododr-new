import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Controller/Settlementcontroller.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/utils/appButtons.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/appTextField.dart';
import 'package:zodo_dr/utils/utils.dart';

class AddBankScreen extends StatelessWidget {
  AddBankScreen({super.key});

  final Settlementcontroller controller = Get.find<Settlementcontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => MyEarningAppBar(
              name:
                  controller.hasBankDetails.value ? "Update Bank" : "Add Bank",
            ),
          ),
          SpacerH(16.h),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appText.primaryText(
                              text: "Account Holder Name",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.holderNameController,
                              hint: "Enter account holder name",
                            ),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Bank Account Number",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.accountNumberController,
                              hint: "Enter account number",
                              keyType: TextInputType.number,
                            ),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Bank Name",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.bankNameController,
                              hint: "Enter bank name",
                            ),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "IFSC Code",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.ifscController,
                              hint: "Enter IFSC code",
                            ),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Branch Name",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.branchController,
                              hint: "Enter branch name",
                            ),

                            // NOTE: Collected in UI but NOT sent to API.
                            // No "branch" field in confirmed bank_details
                            // schema. Confirm with TL/backend before
                            // removing or wiring it through.
                            SpacerH(22.h),
                            appText.primaryText(
                              text: "UPI ID (Optional)",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(
                              controller: controller.upiIDController,
                              hint: "Enter UPI ID",
                            ),
                            SpacerH(100.h),
                          ],
                        ),
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
                      name: "Verify",
                      isLoading: controller.isBankSubmitting.value,
                      onClick: () {
                        if (!controller.isBankSubmitting.value) {
                          controller.addBankAccount();
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
