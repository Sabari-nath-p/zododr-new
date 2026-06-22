import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class Appointmentdetailsscreenappbar extends StatelessWidget {
  Appointmentdetailsscreenappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      //   width: 390.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(
        //     image: AssetImage("Assets/Images/authgbg.png"),
        //     fit: BoxFit.cover)
      ),
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 14.h,
        left: 20.w,
        right: 20.w,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              // color: Colors.white,
              size: 20.w,
            ),
          ),
          SpacerW(10.w),
          appText.primaryText(
            text: "Patient Profile",
            //color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
