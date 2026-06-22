import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/AuthenticationScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Controller/HomeController.dart';
import 'package:zodo_dr/Utils/appText.dart' show appText;
import 'package:zodo_dr/Utils/utils.dart';
import 'package:zodo_dr/main.dart' as AppRoutes;

class DashHeaderView extends StatelessWidget {
  DashHeaderView({super.key});

  Homecontroller ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.h,
      //   width: 390.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/Images/authgbg.png"),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(
        top: 55.h,
        bottom: 14.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "Assets/Images/zodosplashLogo.png",
                  width: 80.w,
                  color: Colors.white,
                ),
                SpacerH(2.h),
                appText.primaryText(
                 text: "Hi , ${ctrl.utils.user?.name ?? ''}",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ],
            ),
          ),
         PopupMenuButton<String>(
  color: Colors.white,
  offset: const Offset(0, 45),
  icon: Icon(
    EvaIcons.settings2Outline,
    size: 28.w,
    color: Colors.white,
  ),
  onSelected: (value) {
    if (value == "logout") {
      _showLogoutDialog(context);
    }
  },
  itemBuilder: (context) => [
    PopupMenuItem(
      value: "logout",
      child: Row(
        children: [
          const Icon(
            Icons.logout_rounded,
            color: Colors.red,
          ),
          SizedBox(width: 10.w),
          const Text("Logout"),
        ],
      ),
    ),
  ],
),
          SpacerW(12.w),
          Icon(EvaIcons.bellOutline, size: 28.w, color: Colors.white),
        ],
      ),
    );
  }
}
void _showLogoutDialog(BuildContext context) {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      title: Text(
        "Logout",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        "Are you sure you want to log out of your account?",
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black87,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();

           Get.offAll(() => AuthenticationScreen());
          },
          child: const Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}