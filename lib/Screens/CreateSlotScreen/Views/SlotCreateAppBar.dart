import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/utils.dart';

class SlotCreateAppBar extends StatelessWidget {
  String name;
  VoidCallback? onCalendarTap;

  SlotCreateAppBar({
    super.key,
    required this.name,
    this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
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
          /// BACK BUTTON
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              EvaIcons.arrow_ios_back,
              color: Colors.white,
              size: 30.w,
            ),
          ),

          SpacerW(10.w),

          /// TITLE
          Expanded(
            child: appText.primaryText(
              text: name,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),

          /// CALENDAR ICON (RIGHT SIDE)
          InkWell(
            onTap: onCalendarTap,
            child: Icon(
              EvaIcons.calendar_outline,
              color: Colors.white,
              size: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}