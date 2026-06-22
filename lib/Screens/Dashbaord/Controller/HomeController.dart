import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';

class Homecontroller extends GetxController {
  Utilscontroller utils = Get.find();
  List<BookingModel> bookings = [];

  fetchTodayBooking() async {
     if (utils.user?.id == null) return;
    print(await ApiService.getAuthToken());
    ApiService.request(
      endpoint:
          "bookings/doctor/${utils.user!.id}/bookings?page=1&limit=100&appointmentDate=${DateFormat("yyyy-MM-dd").format(DateTime.now())} d",
      method: Api.GET,

      onSuccess: (data) {
        for (var data in data.data["data"]) {
          bookings.add(BookingModel.fromJson(data));
        }

        update();
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTodayBooking();
  }
}
