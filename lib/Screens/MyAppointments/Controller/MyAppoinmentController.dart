import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/AppointmentDetailsScreen/Model/PrescriptionModel.dart';
import 'package:zodo_dr/Screens/Dashbaord/Model/BookingModel.dart';
import 'package:zodo_dr/Screens/MyAppointments/Model/MedicalRecordModel.dart';
import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';
import 'package:zodo_dr/Utils/src.dart';

class MyAppointmentController extends GetxController {
  final Utilscontroller utils = Get.find();

  int selected = 0;
  DateTime? selectedDate;

  List<BookingModel> bookings = [];
  bool isLoading = false;
  List<MedicalRecordModel> medicalRecords = [];
  bool isMedicalLoading = false;

  bool isMarkLoading = false;

  List<XFile> prescriptionImage = [];
   var prescriptions = <Prescription>[];
bool isPrescriptionLoading = false;



  Future<void> fetchBookings({
    String? status,
    DateTime? date,
  }) async {
    if (utils.user?.id == null) return;

    isLoading = true;
    update();

    String endpoint =
        "bookings/doctor/${utils.user!.id}/bookings?page=1&limit=100";

    if (status != null && status.isNotEmpty) {
      endpoint += "&status=$status";
    }

    if (date != null) {
      endpoint +=
          "&Date=${DateFormat('yyyy-MM-dd').format(date)}";
    }

    ApiService.request(
      endpoint: endpoint,
      method: Api.GET,
      onSuccess: (data) {
        bookings.clear();

        for (var item in data.data["data"]) {
          bookings.add(BookingModel.fromJson(item));
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        update();
      },
    );
  }

  Future<void> fetchMedicalRecords({
  required String userId,
  String? childUserId,
}) async {
  isMedicalLoading = true;
  medicalRecords.clear();

  String endpoint =
      "user-medical-records?user_id=$userId&page=1&limit=20";

  if (childUserId != null && childUserId.isNotEmpty) {
    endpoint += "&child_user_id=$childUserId";
  }

  ApiService.request(
    endpoint: endpoint,
    method: Api.GET,
    onSuccess: (data) {
      medicalRecords.clear();

      for (var item in data.data["data"]) {
        medicalRecords.add(MedicalRecordModel.fromJson(item));
      }

      isMedicalLoading = false;
      update();
    },
    onError: (error) {
      isMedicalLoading = false;
      update();
    },
  );
}

  void changeTab(int index) {
  selected = index;

  fetchBookings(
    status: selected == 0
        ? "ACCEPTED"
        : "COMPLETED",
    date: selectedDate,
  );

  update();
}

   void changeDate(DateTime date) {
  selectedDate = date;

  fetchBookings(
    status: selected == 0
        ? "ACCEPTED"
        : "COMPLETED",
    date: selectedDate,
  );
}
  
  Future<void> markAppointmentComplete(String bookingId) async {
  isMarkLoading = true;
  update();

  List<String> imageKeys = [];

  if (prescriptionImage.isNotEmpty) {
    for (final image in prescriptionImage) {
      String? key = await fileUpload(image.path, isKey: true);

      if (key != null) {
        imageKeys.add(key);
      }
    }
  }

  await ApiService.request(
    endpoint: "booking-prescriptions",
    method: Api.POST,
    body: {
      "booking_id": bookingId,
      "files": imageKeys,
    },
    onSuccess: (response) async {
      if (response.statusCode == 201) {
        Customalerts.successAlert(
          title: "Prescription uploaded successfully",
        );

        await ApiService.request(
          endpoint: "bookings/$bookingId/mark-complete",
          method: Api.PATCH,
          onSuccess: (response) async {
            Customalerts.successAlert(
              title: "Appointment marked as completed",
            );

            prescriptionImage.clear();

            await fetchBookings(
              status: selected == 0 ? "STARTED" : "COMPLETED",
              date: selectedDate,
            );

            isMarkLoading = false;
            update();

            Get.back();
          },
          onError: (error) {
            isMarkLoading = false;
            update();

            Customalerts.errorAlert(
              title: "Failed to mark appointment as completed",
              body: error.toString(),
            );
          },
        );
      } else {
        isMarkLoading = false;
        update();

        Customalerts.errorAlert(
          title: "Failed to upload prescription",
        );
      }
    },
    onError: (error) {
      isMarkLoading = false;
      update();

      Customalerts.errorAlert(
        title: "Failed to upload prescription",
        body: error.toString(),
      );
    },
  );
}




 Future<void> fetchPrescriptions({required String bookingId}) async {
  isPrescriptionLoading = true;
  update();

  await ApiService.request(
    endpoint:
        "booking-prescriptions?booking_id=$bookingId&page=1&limit=20",
        //sortBy=id:ASC
    method: Api.GET,
    onSuccess: (res) {
      final data = res.data;

      prescriptions = List<Prescription>.from(
        data['data'].map((e) => Prescription.fromJson(e)),
      );
    },
    onError: (e) {},
  );

  isPrescriptionLoading = false;
  update();
}
  @override
void onInit() {
  super.onInit();

  selected = 0;

  fetchBookings(
    status: "STARTED" ,
    date: selectedDate,
  );
}}