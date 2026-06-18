import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/Controller/authenticationController.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/RegistrationScreen2.dart';
import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/appButtons.dart';
import 'package:zodo_dr/Utils/appText.dart';
import 'package:zodo_dr/Utils/appTextField.dart';
import 'package:zodo_dr/Utils/supportModels/SpecialisationModel.dart';
import 'package:zodo_dr/Utils/supportModels/disctrictModel.dart';
import 'package:zodo_dr/Utils/utils.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  AuthenticationController ctrl = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: appButton.PrimaryButton(
        name: "Register",
        isMargin: true,
        onClick: () {
          ctrl.validateAndAlert(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerH(20.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined, size: 20.w),
                  ),
                  appText.primaryText(
                    text: "  Enter Basic information",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(child: Container()),
                  appText.primaryText(
                    text: "Step",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  appText.primaryText(
                    text: " 1",
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
                          // SpacerH(12.h),
                          SpacerH(16.h),
                          appText.primaryText(
                            text: "Full Name",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(10.h),
                          tBox(
                            hint: "Enter your full offical name",
                            controller: ctrl.fullNameController,
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Enter your email",
                            controller: ctrl.emailController,
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Enter your contact number",
                            controller: ctrl.phoneController,
                            keyType: TextInputType.numberWithOptions(),
                          ),
                          SpacerH(16.h),
                          appText.primaryText(
                            text: "Specialisation",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(10.h),
                          SizedBox(
                            width: 360.w,
                            height: 58.h,
                            child: DropdownButtonFormField<SpecialisationModel>(
                              items:
                                  ctrl.utils.specialisations
                                      .map(
                                        (location) => DropdownMenuItem<
                                          SpecialisationModel
                                        >(
                                          value: location,
                                          child: Text(
                                            location.name ?? "",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              value: ctrl.selectedSpecialisation,
                              onChanged: (value) {
                                // handle selection

                                ctrl.selectedSpecialisation = value;
                                ctrl.utils.selectedSpecialisation = value;
                              },
                              //icon: Container(),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Specilisation',
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Color(0xFF262626).withOpacity(.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 14.w,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                // suffixIcon: Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: Image.asset(
                                //     "Assets/Icons/gps.png",
                                //     width: 24.sp,
                                //     height: 24.sp,
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          SpacerH(16.h),
                          appText.primaryText(
                            text: "District",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(10.h),
                          SizedBox(
                            width: 360.w,
                            height: 58.h,
                            child: DropdownButtonFormField<DistrictModel>(
                              items:
                                  ctrl.utils.districtList
                                      .map(
                                        (location) =>
                                            DropdownMenuItem<DistrictModel>(
                                              value: location,
                                              child: Text(
                                                location.name ?? "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                      )
                                      .toList(),
                              value: ctrl.selectedDistrict,
                              onChanged: (value) {
                                // handle selection

                                ctrl.selectedDistrict = value;
                                ctrl.utils.selectedDistrict = value;
                              },
                              //icon: Container(),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'District',
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Color(0xFF262626).withOpacity(.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 14.w,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffDFDFDF),
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                // suffixIcon: Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: Image.asset(
                                //     "Assets/Icons/gps.png",
                                //     width: 24.sp,
                                //     height: 24.sp,
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          SpacerH(16.h),
                          appText.primaryText(
                            text: "Qualifications",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(10.h),
                          tBox(
                            hint: "Enter your register number",
                            controller: ctrl.registrationNameController,
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Enter your qualification",
                            controller: ctrl.qualificationController,
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Enter your council name",
                            controller: ctrl.councilController,
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Enter your passing year",
                            controller: ctrl.passingYear,
                            keyType: TextInputType.numberWithOptions(),
                          ),
                          SpacerH(16.h),
                          tBox(
                            hint: "Practice started in (year yyyy)",
                            isEnable: false,
                            controller: ctrl.expericenCOntroller,
                            keyType: TextInputType.numberWithOptions(),
                          ),

                          SpacerH(16.h),
                          appText.primaryText(
                            text: "Consultaion  Details",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SpacerH(10.h),
                          tBox(
                            hint: "Enter your consultation fee",
                            keyType: TextInputType.numberWithOptions(),

                            controller: ctrl.counsultationFees,
                          ),

                          //SpacerH(16.h),
                          SizedBox(height: 10),
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
