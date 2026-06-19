import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Screens/MyAppointments/Controller/MyAppoinmentController.dart';
import 'package:zodo_dr/Screens/MyAppointments/Views/appoinmentAppBar.dart';
import 'package:zodo_dr/Screens/MyAppointments/Views/myAppoinmentListCard.dart';
import 'package:zodo_dr/Screens/MyAppointments/Views/myApponmentCalender.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';


class MyAppointmentScreen extends StatelessWidget {


  
  MyAppointmentScreen({super.key,});
  Myappointmentcontroller controller = Get.put(Myappointmentcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<Myappointmentcontroller>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppointmentAppBar(),
            SpacerH(20.h),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpacerW(395),
                  Container(
                    width: 361.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xff787880).withOpacity(.12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _appointmentMenu(controller.selected == 0, name: "New"),
                        _appointmentMenu(controller.selected == 1, name: "History")
                      ],
                    ),
                  ),
                  SpacerH(16.h),
                  MyAppointmentCalender(),
                  for (int i = 0; i < 10; i++) 
                  MyappointmentsListCard()
                ],
              ),
            ))
          ],
        );
      }),
    );
  }
}

Widget _appointmentMenu(bool selected, {String name = "button"}) {
  return InkWell(
    onTap: () {
      Myappointmentcontroller controller = Get.put(Myappointmentcontroller());
      if (controller.selected == 1) {
        controller.selected = 0;
      } else {
        controller.selected = 1;
      }
      controller.update();
    },
    child: Container(
      width: 178.1.w,
      height: 46.h,
      alignment: Alignment.center,
      decoration: (!selected)
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      color: Colors.black.withOpacity(.01))
                ]),
      child: appText.primaryText(
          text: name, fontSize: 13.sp, fontWeight: FontWeight.w500),
    ),
  );
}