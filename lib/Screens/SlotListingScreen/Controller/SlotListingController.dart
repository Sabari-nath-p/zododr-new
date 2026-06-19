import 'dart:developer';
import 'package:get/get.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';



class SlotListingController extends GetxController {
  static SlotListingController get to => Get.find();

  DateTime selectedDate = DateTime.now();


  bool isLoading = false;

 
}