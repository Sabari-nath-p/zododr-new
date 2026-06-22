import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/AppointmentResultView.dart';
import 'package:zodo_dr/Screens/MyAppointments/Model/MedicalRecordModel.dart';
import 'package:zodo_dr/Utils/ImagesList.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class PatientDocCard extends StatelessWidget {
  final String title;
  final List<MedicalRecordModel> records;
  final bool isLoading;

  const PatientDocCard({
    super.key,
    required this.title,
    required this.records,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      width: 360.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded),
          SpacerW(6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText.primaryText(
                  text: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),

                SpacerH(12.h),

                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (records.isEmpty)
                  appText.primaryText(
                    text: "No medical records found",
                    fontSize: 13.sp,
                    color: Colors.grey,
                  )
                else
                  ...List.generate(records.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _docItem(
                        "Medical Record ${index + 1}",
                        records[index].file ?? "",
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}Widget _docItem(String title, String url) {
  return Row(
    children: [
      Image.asset(
        img.pdfImage,
        width: 25.w,
      ),
      SpacerW(5.w),
      Expanded(
        child: appText.primaryText(
          text: title,
          fontWeight: FontWeight.w500,
          color: const Color(0xff8C8C8C),
          fontSize: 13.sp,
        ),
      ),
      InkWell(
        onTap: () async {
          if (url.isEmpty) return;

          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          );
        },
        child: appText.primaryText(
          text: "View",
          fontWeight: FontWeight.w600,
          color: const Color(0xff3185E6),
          fontSize: 13.sp,
        ),
      ),
    ],
  );
}