import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Utils/ImagesList.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class Hmchatcard extends StatelessWidget {
  const Hmchatcard({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        width: 361.w,
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 22.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText.primaryText(
                    text: "Chats",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SpacerH(8.h),
                  appText.primaryText(
                    text: "All appointment Chat and history",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Image.asset(img.profileIcon, width: 63.h, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
