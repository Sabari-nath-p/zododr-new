import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/appText.dart';

class appButton {
  static PrimaryButton({
    var name,
    Function? onClick,
    bool isMargin = false,
    bool isLoading = false,
  }) => GestureDetector(
    onTap: () {
      if (onClick != null) {
        onClick();
      }
    },
    child: Container(
      width: 390.w,
      alignment: Alignment.center,
      height: 54.h,
      margin:
          (!isMargin)
              ? null
              : EdgeInsets.only(bottom: 20.h, right: 16.w, left: 16.w),
      child:
          (isLoading)
              ? LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 24.sp,
              )
              : appText.primaryText(
                text: "${name ?? "--:--"}",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.sp,
              ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.PrimaryColor,
      ),
    ),
  );
}
