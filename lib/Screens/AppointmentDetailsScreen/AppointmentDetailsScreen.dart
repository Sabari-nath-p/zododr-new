import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:zodo_dr/Screens/AppointmentDetailsScreen/VideoCallScreen.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/AppointmentDetailsScreenAppbar.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientDetailsCard.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/PatientProfileItem.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Views/patientDocCard.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Screens/MyAppointments/Controller/MyAppoinmentController.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/appButtons.dart';


class AppointmentDetailScreen extends StatefulWidget {
  final BookingModel booking;

  const AppointmentDetailScreen({super.key, required this.booking});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final MyAppointmentController controller = Get.put(MyAppointmentController());
 late BookingModel booking;
 
  @override
  void initState() {
    super.initState();

    booking = widget.booking;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchMedicalRecords(
        userId: booking.userId!,
        childUserId: booking.childUserId,
      );

      await controller.fetchPrescriptions(
        bookingId: booking.id!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = "";

    if (booking.appointmentDate != null &&
        booking.appointmentDate!.isNotEmpty) {
      try {
        formattedDate = DateFormat(
          "dd MMM yyyy",
        ).format(DateTime.parse(booking.appointmentDate!));
      } catch (_) {
        formattedDate = booking.appointmentDate!;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
   bottomNavigationBar:
    booking.status?.toUpperCase() == "COMPLETED"
        ? null
        : Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
            child: appButton.PrimaryButton(
              name: "Start Call",
              onClick: () async {
                await videoCallScreen(
                  bookingId: booking.id!,
                  userName: booking.userDetails?.name ?? "User",
                );
              },
            ),
          ),
      body: SafeArea(
        child: Column(
          children: [
            Appointmentdetailsscreenappbar(),
            SizedBox(height: 5.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    PatientdetailCard(booking: booking),

                    SizedBox(height: 20.h),

                    PatientProfileItem(
                      icon: Icons.info_outline,
                      title: "Consult Details",
                      body: booking.type ?? "General Consultation",
                    ),

                    PatientProfileItem(
                      icon: Icons.calendar_month_outlined,
                      title: "Appointment Date",
                      body: formattedDate,
                    ),

                    PatientProfileItem(
                      icon: Icons.watch_later_outlined,
                      title: "Time",
                      body: booking.timeSlot ?? "--",
                    ),

                    PatientProfileItem(
                      icon: Icons.file_copy,
                      title: "Reason",
                      body: booking.reason ?? "No reason provided",
                    ),

                    GetBuilder<MyAppointmentController>(
                      builder: (controller) {
                        return PatientDocCard(
                          title: "Medical Records",
                          records: controller.medicalRecords,
                          isLoading: controller.isMedicalLoading,
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                   GetBuilder<MyAppointmentController>(
  builder: (controller) {
    final isCompleted =
        booking.status?.toUpperCase() == "COMPLETED";

    return Column(
      children: [
        SizedBox(height: 20.h),

        if (isCompleted)
          _buildPrescriptionList(controller)
        else ...[
          _buildAttachmentSection(),
          SizedBox(height: 20.h),
          _buildActionButtons(booking),
        ],
      ],
    );
  },
),

                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAttachmentSection() {
  return GetBuilder<MyAppointmentController>(
    builder: (controller) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xffF8F9FE),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attachments",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 16.h),

            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () async {
                if (controller.prescriptionImage.length >= 3) {
                  Customalerts.warningAlert(title: "Maximum 3 images allowed");
                  return;
                }

                final ImageSource?
                source = await showModalBottomSheet<ImageSource>(
                  context: Get.context!,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  builder: (_) {
                    return SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt_outlined),
                              title: const Text("Camera"),
                              onTap: () => Get.back(result: ImageSource.camera),
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library_outlined),
                              title: const Text("Gallery"),
                              onTap:
                                  () => Get.back(result: ImageSource.gallery),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (source == null) return;

                final picker = ImagePicker();

                final image = await picker.pickImage(
                  source: source,
                  imageQuality: 60,
                );

                if (image != null) {
                  controller.prescriptionImage.add(image);
                  controller.update();
                }
              },
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 34.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Tap to Attach Image",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${controller.prescriptionImage.length}/3 Images",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            if (controller.prescriptionImage.isEmpty)
              Center(
                child: Text(
                  "No attachments added",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ),

            if (controller.prescriptionImage.isNotEmpty)
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: List.generate(controller.prescriptionImage.length, (
                  index,
                ) {
                  final image = controller.prescriptionImage[index];

                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          File(image.path),
                          width: 80.w,
                          height: 80.w,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: -5,
                        right: -5,
                        child: InkWell(
                          onTap: () {
                            controller.prescriptionImage.removeAt(index);
                            controller.update();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
          ],
        ),
      );
    },
  );
}

Widget _buildActionButtons(BookingModel booking) {
  return GetBuilder<MyAppointmentController>(
    builder: (controller) {
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 52.h,
          child: ElevatedButton(
            onPressed:
                controller.isMarkLoading
                    ? null
                    : () {
                      controller.markAppointmentComplete(booking.id!);
                    },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r), // Rounded corners
              ),
            ),
            child:
                controller.isMarkLoading
                    ? LoadingAnimationWidget.stretchedDots(
                      color: Colors.white,
                      size: 24.w,
                    )
                    : const Text(
                      "Mark Complete",
                      style: TextStyle(color: Colors.white),
                    ),
          ),
        ),
      );
    },
  );
}
Widget _buildPrescriptionList(MyAppointmentController controller) {
  if (controller.isPrescriptionLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (controller.prescriptions.isEmpty) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        "No prescriptions found",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xffF8F9FE),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prescriptions",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),

        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: List.generate(
            controller.prescriptions.length,
            (index) {
              final item = controller.prescriptions[index];

              // 👇 Print URL
              debugPrint("Prescription URL: ${item.file}");

              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: Get.context!,
                    builder: (_) => Dialog(
                      child: InteractiveViewer(
                        child: Image.network(
                          item.file,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint("Image Error: $error");
                            debugPrint("Image URL: ${item.file}");

                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.broken_image,
                                size: 80,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    item.file,
                    width: 90.w,
                    height: 90.w,
                    fit: BoxFit.cover,
                    loadingBuilder:
                        (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return SizedBox(
                        width: 90.w,
                        height: 90.w,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint("Image Error: $error");
                      debugPrint("Image URL: ${item.file}");

                      return Container(
                        width: 90.w,
                        height: 90.w,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}