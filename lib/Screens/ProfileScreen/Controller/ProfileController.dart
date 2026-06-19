import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';
import 'package:zodo_dr/Utils/src.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController councilController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController pricingController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  RxString profilePicUrl = "".obs;
  RxString status = "".obs;

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool isUploadingPic = false.obs;

  Utilscontroller get _utils => Get.find<Utilscontroller>();
  String? get doctorId => _utils.user?.id;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  loadProfile() {
    final user = _utils.user;
    if (user == null) return;

    nameController.text = user.name ?? "";
    aboutController.text = user.about ?? "";
    emailController.text = user.email ?? "";
    phoneController.text = user.phoneNumber ?? "";
    cityController.text = user.city ?? "";

    councilController.text = user.registrationDetails?.councilName ?? "";
    qualificationController.text =
        user.registrationDetails?.qualification ?? "";
    registrationNoController.text =
        user.registrationDetails?.registrationNumber ?? "";
    pricingController.text = user.pricing ?? "";
    durationController.text = user.consultationDuration?.toString() ?? "";

    profilePicUrl.value = user.profilePic ?? "";
    status.value = user.status ?? "";
  }

  // ---------------------------------------------------------
  // UPDATE PROFILE — partial PATCH, same endpoint as bank update
  // NOTE: email is intentionally NOT sent — should not be edited.
  // ---------------------------------------------------------
  updateProfile() async {
    if (doctorId == null) return;

    if (nameController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Name Required",
        body: "Please enter your name.",
      );
      return;
    }

    isSaving.value = true;

    await ApiService.request(
      endpoint: "doctors/$doctorId",
      method: Api.PATCH,
      body: {
        "id": doctorId,
        "name": nameController.text.trim(),
        "about": aboutController.text.trim(),
        "city": cityController.text.trim(),
        "pricing": double.tryParse(pricingController.text.trim()) ?? 0,
        "consultation_duration":
            int.tryParse(durationController.text.trim()) ?? 0,
        "registration_details": {
          "council_name": councilController.text.trim(),
          "qualification": qualificationController.text.trim(),
          "registration_number": registrationNoController.text.trim(),
        },
      },
      onSuccess: (data) {
        Customalerts.successAlert(
          title: "Profile Updated",
          body: "Your profile has been saved successfully.",
        );
        _utils.fetchUser(); // refresh local profile
        Get.back();
      },
      onError: (e) {
        Customalerts.errorAlert(
          title: "Failed",
          body: "Could not update profile. Please try again.",
        );
      },
    );

    isSaving.value = false;
  }

  // ---------------------------------------------------------
  // PROFILE PICTURE UPLOAD
  // ---------------------------------------------------------
  pickAndUploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null || result.files.single.path == null) return;

    isUploadingPic.value = true;

    final url = await fileUpload(result.files.single.path!);

    if (url == null) {
      isUploadingPic.value = false;
      Customalerts.errorAlert(
        title: "Upload Failed",
        body: "Could not upload image. Please try again.",
      );
      return;
    }

    profilePicUrl.value = url;

    if (doctorId == null) {
      isUploadingPic.value = false;
      return;
    }

    await ApiService.request(
      endpoint: "doctors/$doctorId",
      method: Api.PATCH,
      body: {"id": doctorId, "profile_pic": url},
      onSuccess: (data) {
        _utils.fetchUser();
      },
      onError: (e) {
        Customalerts.errorAlert(
          title: "Failed",
          body: "Could not save profile picture.",
        );
      },
    );

    isUploadingPic.value = false;
  }
}
