import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/Controller/authenticationController.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/OtpScreen.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/RegistrationScreen.dart';
import 'package:zodo_dr/Utils/ImagesList.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/appTextField.dart';
import 'package:zodo_dr/Utils/utils.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});
  AuthenticationController authCtrl = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthenticationController>(
        builder: (__) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      img.AuthenticationGreenBg,
                      height: 228.h,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Image.asset(
                          img.zodoSplashLogo,
                          color: Colors.white,
                          width: 210.w,
                          height: 100.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      appText.primaryText(
                        text: "Login to Zodo AI",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      SpacerH(12.h),
                      tBox(
                        keyType: TextInputType.numberWithOptions(),
                        controller: __.phoneAuthText,
                        hint: "Enter Mobile Number",
                      ),
                      SpacerH(24.h),
                      appButton.PrimaryButton(
                        name: "Login",
                        isLoading: __.isLoading,
                        onClick: () {
                          __.sentOtp();
                        },
                      ),
                      SpacerH(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpacerW(10),
                          appText.primaryText(
                            text: "I Don’t Have account? ",
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => RegistrationScreen(),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: appText.primaryText(
                              text: "Register Now",
                              color: Color(0xff3795FF),
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
