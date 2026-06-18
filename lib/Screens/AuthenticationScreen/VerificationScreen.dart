import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/AuthenticationScreen.dart';

import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/utils.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "Assets/Images/verification.png",
                    height: 200.h,
                    width: 364.w,
                  ),
                ),
              ),
              appButton.PrimaryButton(
                name: "Logout",
                onClick: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString("STATUS", "OUT");
                  Get.offAll(() => AuthenticationScreen());
                },
              ),
              SpacerH(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
