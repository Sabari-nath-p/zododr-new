import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodo_dr/Screens/Dashbaord/Controller/HomeController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';
import 'package:zodo_dr/Utils/supportModels/SpecialisationModel.dart';
import 'package:zodo_dr/Utils/supportModels/UserModel.dart';
import 'package:zodo_dr/Utils/supportModels/disctrictModel.dart';
import 'package:zodo_dr/main.dart';

class Utilscontroller extends GetxController {
  List<DistrictModel> districtList = [];
  DistrictModel? selectedDistrict;
  UserModel? user;

  List<SpecialisationModel> specialisations = [];
  SpecialisationModel? selectedSpecialisation;

  fetchDistrict() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.request(
      endpoint: "districts",
      method: Api.GET,
      requiresAuth: false,
      onSuccess: (data) async {
        for (var dis in data.data["data"]) {
          districtList.add(DistrictModel.fromJson(dis));
        }

        update();
        selectedDistrict = districtList.first;

        if (pref.getString("STATUS") == "IN") await fetchUser();

        runApp(ZodoDoctorApp());
      },
    );
  }

  DistrictModel? idtoDistrict(String id) {
    for (var data in districtList) {
      if (data.id == id) {
        return data;
      }
    }
    return null;
  }

  fetchSpecilization() async {
    await ApiService.request(
      endpoint: "specialisations",
      method: Api.GET,
      requiresAuth: false,
      onSuccess: (data) {
        for (var dis in data.data["data"]) {
          specialisations.add(SpecialisationModel.fromJson(dis));
        }
        update();
        selectedSpecialisation = specialisations.first;
      },
    );
  }

  updateCountry() async {
    ApiService.request(
      endpoint: "users/${user!.id!}",
      method: Api.PATCH,
      body: {"district_id": selectedDistrict!.id},
    );
  }

  Future<void> fetchUser() async {
  await ApiService.request(
    endpoint: "doctors/me",
    method: Api.GET,
    requiresAuth: true,
    onSuccess: (data) {
      if (data.data["data"] != null) {
        user = UserModel.fromJson(data.data["data"]);

        login = user!.status == "pending" ? "pending" : "IN";

        update();

        // Notify HomeController
        if (Get.isRegistered<Homecontroller>()) {
          Get.find<Homecontroller>().fetchTodayBooking();
        }
      } else {
        login = "";
      }
    },
  );
}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchDistrict();
    fetchSpecilization();
  }
}
