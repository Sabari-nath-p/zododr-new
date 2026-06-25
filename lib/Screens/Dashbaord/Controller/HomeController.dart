import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';

class Homecontroller extends GetxController {
  final Utilscontroller utils = Get.find();

  List<BookingModel> bookings = [];
  bool isLoading = false;

  Future<void> fetchTodayBooking() async {
  print("===== fetchTodayBooking =====");
  print("User: ${utils.user}");
  print("User ID: ${utils.user?.id}");

  if (utils.user?.id == null) {
    print("User ID is null");
    return;
  }

  isLoading = true;
  bookings.clear();
  update();

  final endpoint =
      "bookings/doctor/${utils.user!.id}/bookings?page=1&limit=100&Date=${DateFormat('yyyy-MM-dd').format(DateTime.now())}";

  print(endpoint);

  ApiService.request(
    endpoint: endpoint,
    method: Api.GET,
    onSuccess: (response) {
      print(response.data);

      bookings.clear();

      for (final item in response.data["data"]) {
        bookings.add(BookingModel.fromJson(item));
      }

      print("Bookings: ${bookings.length}");

      isLoading = false;
      update();
    },
    onError: (error) {
      print(error);

      bookings.clear();
      isLoading = false;
      update();
    },
  );
}

  @override
void onInit() {
  super.onInit();

  print("HomeController onInit");

  fetchTodayBooking();
}
}