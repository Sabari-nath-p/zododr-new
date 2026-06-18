import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/Controller/authenticationController.dart';
import 'package:zodo_dr/Utils/Colors.dart';

class OTPVerificationScreen extends StatelessWidget {
  OTPVerificationScreen({super.key});
  TextEditingController otpText = TextEditingController();
  final pinputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.PrimaryColor),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: GetBuilder<AuthenticationController>(
          builder: (_a) {
            return ElevatedButton(
              onPressed: () async {
                bool status = await _a.VerifyOTP(otpText.text);
                // Get.bottomSheet(NewRegView(), isScrollControlled: true);
              },
              child: Container(
                height: 48.h,
                width: double.infinity,
                alignment: Alignment.center,
                child:
                    (_a.isLoading)
                        ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 24,
                        )
                        : Text(
                          "Continue",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GetBuilder<AuthenticationController>(
            builder: (_a) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Verify OTP",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "Enter the 4 digit OTP sent on ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " ${_a.phoneAuthText.text}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Pinput(
                    controller: otpText,
                    defaultPinTheme: PinTheme(
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(11.r),
                        color: Colors.white,
                      ),
                    ),
                    focusNode: pinputFocusNode,
                    errorTextStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                    errorText: _a.errorText.isEmpty ? null : _a.errorText,
                    validator: (value) {},
                    errorPinTheme: PinTheme(
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                      width: 52.w,
                      height: 52.w,

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(11.r),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
