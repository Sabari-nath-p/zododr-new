import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Screens/MyEarningScreen/Views/MyEarningAppBar.dart';
import 'package:zodo_dr/Screens/ProfileScreen/Controller/ProfileController.dart';
import 'package:zodo_dr/utils/appButtons.dart';
import 'package:zodo_dr/utils/appText.dart';
import 'package:zodo_dr/utils/appTextField.dart';
import 'package:zodo_dr/utils/utils.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyEarningAppBar(name: "My Profile"),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 25.w,
                    left: 25.w,
                    bottom: 0,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SpacerH(20.h),

                          // ---------------- Profile Picture ----------------
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Obx(
                                () => CircleAvatar(
                                  radius: 45.r,
                                  backgroundColor: Color(0xFFE1EFFF),
                                  backgroundImage:
                                      controller.profilePicUrl.value.isNotEmpty
                                          ? NetworkImage(
                                            controller.profilePicUrl.value,
                                          )
                                          : null,
                                  child:
                                      controller.profilePicUrl.value.isEmpty
                                          ? Icon(
                                            Icons.person,
                                            size: 45.sp,
                                            color: Color(0xFF347D73),
                                          )
                                          : null,
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap:
                                      controller.isUploadingPic.value
                                          ? null
                                          : () =>
                                              controller.pickAndUploadImage(),
                                  child: Container(
                                    width: 28.w,
                                    height: 28.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF347D73),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child:
                                        controller.isUploadingPic.value
                                            ? Padding(
                                              padding: EdgeInsets.all(6),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                            : Icon(
                                              Icons.camera_alt,
                                              size: 14.sp,
                                              color: Colors.white,
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SpacerH(10.h),

                          // ---------------- Status Badge ----------------
                          Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    controller.status.value == "active"
                                        ? Color(0xff05A9CD1A)
                                        : Color(0xFFBEA21620),
                              ),
                              child: appText.primaryText(
                                text:
                                    controller.status.value == "active"
                                        ? "Verified"
                                        : "Pending Verification",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    controller.status.value == "active"
                                        ? Color(0xff05A9CD)
                                        : Color(0xFFBEA216),
                              ),
                            ),
                          ),

                          SpacerH(28.h),

                          // ---------------- Basic Info ----------------
                          _sectionHeader("Basic Info"),
                          SpacerH(14.h),

                          _fieldLabel("Full Name"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.nameController,
                            hint: "Enter your full name",
                          ),
                          SpacerH(18.h),

                          _fieldLabel("About"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.aboutController,
                            hint: "Tell patients about yourself",
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Email"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.emailController,
                            isEnable: false, // email cannot be edited
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Phone Number"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.phoneController,
                            isEnable: false, // read-only, used for login
                          ),
                          SpacerH(18.h),

                          _fieldLabel("City"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.cityController,
                            hint: "Enter your city",
                          ),

                          SpacerH(28.h),

                          // ---------------- Professional Info ----------------
                          _sectionHeader("Professional Info"),
                          SpacerH(14.h),

                          _fieldLabel("Council Name"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.councilController,
                            hint: "e.g. AIIMS",
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Qualification"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.qualificationController,
                            hint: "e.g. MBBS MD",
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Registration Number"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.registrationNoController,
                            hint: "Enter registration number",
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Consultation Fee"),
                          SpacerH(8.h),
                          tBox(
                            prefixText: "₹",
                            controller: controller.pricingController,
                            keyType: TextInputType.number,
                          ),
                          SpacerH(18.h),

                          _fieldLabel("Consultation Duration (mins)"),
                          SpacerH(8.h),
                          tBox(
                            controller: controller.durationController,
                            keyType: TextInputType.number,
                          ),

                          SpacerH(120.h), // space above sticky button
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Obx(
                        () => appButton.PrimaryButton(
                          name: "Save Changes",
                          isLoading: controller.isSaving.value,
                          onClick: () {
                            if (!controller.isSaving.value) {
                              controller.updateProfile();
                            }
                          },
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
  }

  Widget _sectionHeader(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: appText.primaryText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF212121).withOpacity(.7),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: appText.primaryText(
        text: text,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1B1B1B),
      ),
    );
  }
}
