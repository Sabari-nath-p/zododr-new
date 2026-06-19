import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/VideoCallScreen.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/AppointmentDetailsScreenAppbar.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientProfileItem.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/patientDocCard.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/utils.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Appointmentdetailsscreenappbar(),
          SpacerH(16.h),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 90.h),
                  child: Column(
                    children: [
                      const PatientdetailCard(),
                      SpacerH(20.h),

                      PatientProfileItem(
                        icon: Icons.info_outline,
                        title: "Consult Details",
                        body: "General Consultation",
                      ),

                      PatientProfileItem(
                        icon: Icons.calendar_month_outlined,
                        title: "Appointment Date",
                        body: "24 Jun 2026",
                      ),

                      PatientProfileItem(
                        icon: Icons.watch_later_outlined,
                        title: "Time",
                        body: "10:30 AM",
                      ),

                      PatientProfileItem(
                        icon: Icons.file_copy,
                        title: "History",
                        body: "No History Found",
                      ),

                      PatientDocCard(
                        title: "Medical Records",
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 20.h,
                  left: 16.w,
                  right: 16.w,
                  child: appButton.PrimaryButton(
                    name: "Start Call",
                    onClick: () {
                      Get.to(() => VideoCallScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}