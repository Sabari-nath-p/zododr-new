import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/CreateSlotScreen.dart';
import 'package:zodo_dr/Screens/SlotListingScreen/Views/SlotListingAppBar.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/appText.dart';


class SlotListingScreen extends StatelessWidget {
  const SlotListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SlotListingAppBar(),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 25.w,
                  left: 25.w,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 210.h),
                        child: appText.primaryText(
                            text: "No time Slot Created",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
                  )),
              Positioned(
                  bottom: 20.h,
                  right: 25.w,
                  left: 25.w,
                  child: appButton.PrimaryButton(
                      name: "Create Slots",
                      onClick: () {
                        Get.to(() => CreateSlotScreen(),
                            transition: Transition.rightToLeft);
                      }))
            ],
          )),
        ],
      ),
    );
  }
}