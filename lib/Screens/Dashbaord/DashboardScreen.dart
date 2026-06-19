import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/CreateSlotScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/Controller/HomeController.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Screens/Dashbaord/Views/DashHeaderView.dart';
import 'package:zodo_dr/Screens/Dashbaord/Views/HMChatCard.dart';
import 'package:zodo_dr/Screens/Dashbaord/Views/HMUpcommingadpt.dart'
    show HmupcommingadptCard;
import 'package:zodo_dr/Screens/Dashbaord/Views/dbToolCardView.dart';
import 'package:zodo_dr/Screens/MyAppointments/MyAppoinmentScreens.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/MyEarningScreen.dart';
import 'package:zodo_dr/Screens/MyProfileScreen/MyProfileScreen.dart';
import 'package:zodo_dr/Screens/SlotListingScreen/SlotListingScreen.dart';
import 'package:zodo_dr/Utils/ImagesList.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';
import 'package:zodo_dr/Screens/ProfileScreen/ProfileScreen.dart';

class dashBoardScreen extends StatelessWidget {
  dashBoardScreen({super.key});
  Homecontroller ctrl = Get.put(Homecontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<Homecontroller>(
        builder: (__) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashHeaderView(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpacerH(20.h),
                      HmupcommingadptCard(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: appText.primaryText(
                          text: "My Tools",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SpacerH(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Wrap(
                          spacing: 10.w,
                          runSpacing: 12.h,
                          children: [
                            InkWell(
                              onTap: () {
                             
                                 Get.to(() => MyAppointmentScreen( ),
                                   transition: Transition.rightToLeft);
                              },
                              child: dbToolCardView(
                                title: "My Appointments",
                                subtext: "No pending",
                                image: img.appointmentIcon,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => MyEarningScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: dbToolCardView(
                                title: "Earnings",
                                image: img.myEarningIcon,
                                subtext: "Manage all earnings",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                 Get.to(() => CreateSlotScreen(),
                                     transition: Transition.rightToLeft);
                              },
                              child: dbToolCardView(
                                title: "Appointment Settings",
                                image: img.apptSettingIcon,
                                subtext: "",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => ProfileScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: dbToolCardView(
                                title: "Profile",
                                image: img.profileIcon,
                                subtext: "Verified",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SpacerH(12.h),
                      
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
