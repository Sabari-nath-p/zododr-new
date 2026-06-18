import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/Controller/authenticationController.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/VerificationScreen.dart'
    show VerificationScreen;

import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/utils.dart';

class RegistrationScreen2 extends StatelessWidget {
  const RegistrationScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<AuthenticationController>(
        builder:
            (txc) => appButton.PrimaryButton(
              isMargin: true,
              isLoading: txc.isLoading,
              name: "Register",
              onClick: () {
                txc.ValidateSecond();
              },
            ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SpacerH(20.h),
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_outlined, size: 25.w),
                  Expanded(child: Container()),
                  appText.primaryText(
                    text: "Step",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  appText.primaryText(
                    text: " 2",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.PrimaryColor,
                  ),
                  appText.primaryText(
                    text: "/2",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ],
              ),
              Expanded(
                child: GetBuilder<AuthenticationController>(
                  builder: (__) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpacerH(12.h),
                          appText.primaryText(
                            text: "Enter Basic information",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(16.h),
                          uploadDocumentWidget(
                            title: "Profile Picture",
                            type: 1,
                            name:
                                __.profilePicture == null
                                    ? null
                                    : __.profilePicture!.name,
                            imageSelected: (file) {
                              __.profilePicture = file;
                              __.update();
                            },
                          ),
                          SpacerH(16.h),
                          uploadDocumentWidget(
                            title: "Degree Proof",

                            type: 0,
                            name:
                                __.degreeProof == null
                                    ? null
                                    : __.degreeProof!.name,
                            imageSelected: (file) {
                              __.degreeProof = file;
                              __.update();
                            },
                          ),
                          SpacerH(16.h),
                          uploadDocumentWidget(
                            title: "Registration Proof",
                            type: 0,
                            name:
                                __.registrationProof == null
                                    ? null
                                    : __.registrationProof!.name,
                            imageSelected: (file) {
                              __.registrationProof = file;
                              __.update();
                            },
                          ),
                          SpacerH(16.h),
                          SpacerH(100.h),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget uploadDocumentWidget({
  required String title,
  String? name,
  int type = 0,
  required Function(PlatformFile) imageSelected,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      appText.primaryText(text: title, fontWeight: FontWeight.w500),
      SpacerH(10.h),
      InkWell(
        onTap: () async {
          FilePickerResult? file = await FilePicker.platform.pickFiles(
            type: (type == 0) ? FileType.custom : FileType.image,
            allowedExtensions: (type == 0) ? ["pdf"] : null,
          );

          if (file != null) {
            imageSelected(file.files.first);
          }
        },
        child: Container(
          width: 366.w,
          height: 88.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                name == null ? Icons.insert_drive_file : Icons.cloud_upload,
                color: AppColors.PrimaryColor,
                size: 30.sp,
              ),
              SpacerH(12.sp),
              appText.primaryText(
                text: name != null ? "$name" : "Upload",
                color: AppColors.PrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
