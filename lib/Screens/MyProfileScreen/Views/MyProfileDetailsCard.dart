import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/appTextField.dart';
import 'package:zodo_dr/Utils/utils.dart';


class MyProfileDetailsCard extends StatelessWidget {
  MyProfileDetailsCard({super.key});
  TextEditingController regnoController =
      TextEditingController(text: "1234553");
  TextEditingController councilController =
      TextEditingController(text: "Medical Council Kerala");
  TextEditingController passingController = TextEditingController(text: "2006");
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpacerH(24.h),
          appText.primaryText(
              text: "Basic information",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
          SpacerH(16.h),
          tBox(
              hint: "Enter your register number",
              controller: regnoController,
              isEnable: false),
          SpacerH(16.h),
          tBox(
              hint: "Enter your council name",
              controller: councilController,
              isEnable: false),
          SpacerH(16.h),
          tBox(
              hint: "Enter your passing year",
              controller: passingController,
              isEnable: false,
              keyType: TextInputType.numberWithOptions()),
        ],
      ),
    );
  }
}