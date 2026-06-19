import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zodo_dr/Screens/MyProfileScreen/Views/MyProfileDetailsCard.dart';

import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          SpacerH(
            20.h,
          ),
          Row(
            children: [
              SpacerW(16.w),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25.w,
                ),
              ),
              SpacerW(10.w),
              appText.primaryText(
                  text: "Profile", fontWeight: FontWeight.w500, fontSize: 16.sp)
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              SpacerH(25.h),
              Container(
                width: 100.w,
                height: 100.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SpacerH(12.h),
              appText.primaryText(
                  text: "Dr. Sabarinath P",
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp),
              SpacerH(10.h),
              SizedBox(
                width: 200.w,
                child: appText.primaryText(
                    text: "MBBS/MD Gynecologuist/ Obstetrican",
                    fontWeight: FontWeight.w400,
                    align: TextAlign.center,
                    fontSize: 12.sp),
              ),
              SpacerH(8.h),
              appText.primaryText(
                  text: "12 year Experince",
                  fontWeight: FontWeight.w400,
                  align: TextAlign.center,
                  fontSize: 12.sp),
              MyProfileDetailsCard()
            ],
          )))
        ],
      )),
    );
  }
}