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
  MyAppointmentScreen({super.key});
  MyAppointmentController controller = Get.put(MyAppointmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<MyAppointmentController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppointmentAppBar(),
              SpacerH(20.h),
              Expanded(
                child:
                    controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                          child: Column(
                            children: [
                              SpacerW(395),
                              Container(
                                width: 361.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: const Color(
                                    0xff787880,
                                  ).withOpacity(.12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _appointmentMenu(
                                      controller.selected == 0,
                                      index: 0,
                                      name: "New",
                                    ),
                                    _appointmentMenu(
                                      controller.selected == 1,
                                      index: 1,
                                      name: "History",
                                    ),
                                  ],
                                ),
                              ),
                              SpacerH(16.h),
                           MyAppointmentCalender(
  selectedDate: controller.selectedDate ?? DateTime.now(),
  onDateSelected: controller.changeDate,
),

                              if (controller.bookings.isEmpty)
                                Padding(
                                  padding: EdgeInsets.only(top: 100.h),
                                  child: appText.primaryText(
                                    text: "No Appointments Found",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.bookings.length,
                                  itemBuilder: (context, index) {
                                    final booking = controller.bookings[index];

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: MyappointmentsListCard(
                                        booking: booking,
                                      ),
                                    );
                                  },
                                ),
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

Widget _appointmentMenu(
  bool selected, {
  required int index,
  String name = "button",
}) {
  return InkWell(
    onTap: () {
      final controller = Get.find<MyAppointmentController>();
      controller.changeTab(index);
    },
    child: Container(
      width: 178.1.w,
      height: 46.h,
      alignment: Alignment.center,
      decoration:
          selected
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(.01),
                  ),
                ],
              )
              : null,
      child: appText.primaryText(
        text: name,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
