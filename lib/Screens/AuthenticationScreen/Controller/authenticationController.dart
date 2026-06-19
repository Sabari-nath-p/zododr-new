import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/OtpScreen.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/RegistrationScreen2.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/VerificationScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/DashboardScreen.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';
import 'package:zodo_dr/Utils/src.dart';
import 'package:zodo_dr/Utils/supportModels/SpecialisationModel.dart';
import 'package:zodo_dr/Utils/supportModels/disctrictModel.dart';

class AuthenticationController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController expericenCOntroller = TextEditingController();
  TextEditingController registrationNameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController councilController = TextEditingController();
  TextEditingController counsultationFees = TextEditingController();

  TextEditingController passingYear = TextEditingController();
  PlatformFile? profilePicture, degreeProof, registrationProof;
  Utilscontroller utils = Get.find();
  DistrictModel? selectedDistrict;
  SpecialisationModel? selectedSpecialisation;
  bool isLoading = false;
  String userID = "";
  String authToken = "";
  String errorText = "";
  TextEditingController phoneAuthText = TextEditingController();

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  Future<void> setUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("USERID", userID);
    pref.setString("AUTHKEY", authToken);
    pref.setString("STATUS", "IN");
    Utilscontroller utilCtrl = Get.find();
    await utilCtrl.fetchUser();
  }

  void sentOtp() async {
    startLoading();
    await ApiService.request(
      endpoint: "auth/login/user",
      method: Api.POST,
      headers: {"app-type": "doctor"},
      body: {"phone_number": phoneAuthText.text.trim()},
      requiresAuth: false,
      onSuccess: (data) {
        print(data.data);
        if (data.statusCode == 201) {
          userID = data.data["data"]["user"]["id"];
          Get.to(
            () => OTPVerificationScreen(),
            transition: Transition.cupertino,
          );
        } else {
          Customalerts.errorAlert(
            title: "Not a valid number",
            body: "Please try with a valid number",
          );
        }
      },
    );
    stopLoading();
  }

  Future<bool> VerifyOTP(String otp) async {
    startLoading();
    await ApiService.request(
      endpoint: "auth/verify-otp",
      method: Api.POST,
      body: {"user_id": userID, "otp": otp},
      requiresAuth: false,
       onSuccess: (data) async {
  if (data.statusCode == 201) {
    authToken = data.data["data"]["tokens"]["accessToken"];

    final pref = await SharedPreferences.getInstance();

    final doctor = data.data["data"]["doctor"];

    if (doctor != null && doctor["id"] != null) {
      final doctorId = doctor["id"];

      await pref.setString("DOCTOR_ID", doctorId);
    }

    await pref.setString("AUTHKEY", authToken);
    await pref.setString("STATUS", "IN");

    // optional user id save
    final user = data.data["data"]["user"];
    if (user != null && user["id"] != null) {
      await pref.setString("USERID", user["id"]);
    }

    print("TOKEN = $authToken");

    await setUser();

    if (doctor != null && doctor["status"] == "pending") {
      Get.offAll(
        () => VerificationScreen(),
        transition: Transition.rightToLeft,
      );
    } else {
      Get.offAll(
        () => dashBoardScreen(),
        transition: Transition.rightToLeft,
      );
    }
  } else {
    Customalerts.errorAlert(
      title: "Incorrect OTP",
      body: "Please enter correct OTP",
    );
    return;
  }
},
      onUnauthenticated: () {
        Customalerts.errorAlert(
          title: "Incorrrect OTP",
          body: "Please enter correct otp",
        );
      },
    );
    stopLoading();

    return false;
  }

  createDoctor() async {
    startLoading();
    String? pp = await fileUpload(profilePicture!.path!);
    String? dp = await fileUpload(degreeProof!.path!, isKey: true);

    String? rp = await fileUpload(registrationProof!.path!, isKey: true);
    await ApiService.request(
      endpoint: "doctors",
      requiresAuth: false,
      body: {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "profile_pic": pp,
        // "city": "Kochi",
        "pricing": int.parse(counsultationFees.text.trim()),
        "registration_details": {
          "council_name": councilController.text.trim(),
          "qualification": qualificationController.text.trim(),
          "registration_number": registrationNameController.text.trim(),
        },
        // "work_start_date": DateFormat(
        //   "yyyy-MM-dd",
        // ).format(DateTime(int.parse(expericenCOntroller.text))),
        "specifications_id": [selectedSpecialisation!.id!],
        "phone_number": phoneController.text.trim(),
        // "department_ids": ["705e3034-8af5-4f4b-a853-7bc2e1cd38b7"],
        "documents": [
          {"name": "Registratiin Proof", "file": rp},
          {"name": "Degree Proof", "file": dp},
        ],
      },

      onSuccess: (data) {
        print(data.data);
        if (data.statusCode == 201) {
          Customalerts.successAlert(
            title: "Request Submitted Successfully",
            body:
                "Please wait until verification complete. You will be notified once verification completed",
          );

          Get.back();
          Get.back();
          phoneAuthText.text = phoneController.text;
        } else {
          Customalerts.errorAlert(
            title: "Request Submitted Failed",
            body: data.data["validationErrors"],
          );
        }
        log(data.data.toString());
        print(data.data);
      },
    );

    stopLoading();
  }

  void validateAndAlert(BuildContext context) {
    if (fullNameController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Full Name Required",
        body: "Please enter your full name.",
      );
      return;
    }

    if (emailController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Email Required",
        body: "Please enter your email address.",
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Phone Number Required",
        body: "Please enter your phone number.",
      );
      return;
    }

    if (expericenCOntroller.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Experience Required",
        body: "Please enter your experience.",
      );
      return;
    }

    if (registrationNameController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Registration Name Required",
        body: "Please enter your registration name.",
      );
      return;
    }

    if (qualificationController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Qualification Required",
        body: "Please enter your qualification.",
      );
      return;
    }

    if (councilController.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Council Name Required",
        body: "Please enter your council name.",
      );
      return;
    }

    if (counsultationFees.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Consultation Fees Required",
        body: "Please enter the consultation fees.",
      );
      return;
    }
    if (passingYear.text.trim().isEmpty) {
      Customalerts.errorAlert(
        title: "Passing Year Fees Required",
        body: "Please enter the passing year.",
      );
      return;
    }

    if (selectedDistrict == null) {
      Customalerts.errorAlert(
        title: "District Required",
        body: "Please select the district",
      );
      return;
    }
    if (selectedSpecialisation == null) {
      Customalerts.errorAlert(
        title: "Specialisation Required",
        body: "Please select the specialisation",
      );
      return;
    }

    Get.to(() => RegistrationScreen2(), transition: Transition.rightToLeft);
  }

  ValidateSecond() {
    if (profilePicture == null) {
      Customalerts.errorAlert(
        title: "Profile Picture Required",
        body: "Please add the profile picture of doctor",
      );
      return;
    }

    if (degreeProof == null) {
      Customalerts.errorAlert(
        title: "Degree Proof Required",
        body: "Please add the degree proof of doctor",
      );
      return;
    }

    if (registrationProof == null) {
      Customalerts.errorAlert(
        title: "Registration Required",
        body: "Please add the registration proof of doctor",
      );
      return;
    }

    createDoctor();
  }
}
