import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/utils/appButtons.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/appTextField.dart';
import 'package:zodo_dr/utils/utils.dart';

class AddBankScreen extends StatelessWidget {
  AddBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyEarningAppBar(name: "Add Bank"),
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
                            tBox(hint: "Enter account holder name"),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Bank Account Number",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(hint: "Enter account holder name"),

                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Bank Name",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(),

                            SpacerH(22.h),

                            appText.primaryText(
                              text: "IFSC Code",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(),
                            SpacerH(22.h),
                            appText.primaryText(
                              text: "Branch Name",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(),
                            SpacerH(22.h),
                            appText.primaryText(
                              text: "UPI ID (Optional)",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                            ),
                            SpacerH(10.h),
                            tBox(),
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
                  child: appButton.PrimaryButton(name: "Verify"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
