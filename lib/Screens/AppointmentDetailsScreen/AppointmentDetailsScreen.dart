import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/VideoCallScreen.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/AppointmentDetailsScreenAppbar.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientProfileItem.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/patientDocCard.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/utils.dart';

class Appointmentdetailscreen extends StatelessWidget {
  BookingModel booking;
  Appointmentdetailscreen({super.key, required this.booking});

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
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PatientdetailCard(),
                        SpacerH(20.h),
                        PatientProfileItem(
                          icon: Icons.info_outline,
                          title: "Consult Details",
                          body: "Reason: ${booking.reason ?? ""}",
                        ),
                        PatientProfileItem(
                          icon: Icons.calendar_month_outlined,
                          title: "Appointment Date",
                          body: DateFormat(
                            "dd E MMM",
                          ).format(DateTime.parse(booking.appointmentDate!)),
                        ),
                        PatientProfileItem(
                          icon: Icons.watch_later_outlined,
                          title: "Time",
                          body: DateFormat("hh:mm a").format(
                            DateFormat.Hms().parse(booking.timeSlot ?? ""),
                          ),
                        ),
                        PatientProfileItem(
                          icon: Icons.file_copy,
                          title: "History",
                          body: "No History Found",
                        ),
                        PatientDocCard(title: "Medical Records"),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 16.w,
                  right: 16.h,
                  child: appButton.PrimaryButton(
                    name: "Start Call",
                    onClick: () {
                      print("wokring");
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
