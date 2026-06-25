import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class NotificationAppBar extends StatelessWidget {
  NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104.h,
      //   width: 390.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/Images/authgbg.png"),
              fit: BoxFit.cover)),
      padding:
          EdgeInsets.only(top: 55.h, bottom: 14.h, left: 20.w, right: 20.w),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              EvaIcons.arrow_ios_back,
              color: Colors.white,
              size: 30.w,
            ),
          ),
          SpacerW(10.w),
          appText.primaryText(
              text: "Notifications",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp)
        ],
      ),
    );
  }
}