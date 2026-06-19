import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Utils/Colors.dart';

enum SlotMode { date, week }

Future<void> showTimeSlotDialog(
  BuildContext context, {
  required SlotMode mode,
  DateTime? date,
  String? weekId,
  String? weekName,
  String title = "Add Time Slot",
   bool isEdit = false,
  String? availabilityId,
}) async {
  final ctrl = CreateSlotController.to;

  await showDialog(
    context: context,
    builder: (_) {
      return GetBuilder<CreateSlotController>(
        builder: (ctrl) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// ================= HEADER =================
                Text(
                  mode == SlotMode.week
                      ? (weekName ?? "Weekly Slot")
                      : DateFormat("dd MMM yyyy").format(
                          date ?? ctrl.selectedDate,
                        ),
                  style: TextStyle(
                    color: AppColors.PrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= START TIME =================
                buildTimeSelector(
                  context: context,
                  label: "Start Time",
                  time: ctrl.startTime,
                  onTap: () => ctrl.pickStartTime(context),
                ),

                const SizedBox(height: 16),

                /// ================= END TIME =================
                buildTimeSelector(
                  context: context,
                  label: "End Time",
                  time: ctrl.endTime,
                  onTap: () => ctrl.pickEndTime(context),
                ),

                const SizedBox(height: 20),

                /// ================= NOT AVAILABLE =================
                SwitchListTile(
                  value: ctrl.notAvailable,
                  activeColor: AppColors.PrimaryColor,
                  title: const Text("Mark as Not Available"),
                  onChanged: ctrl.changeNotAvailable,
                ),
              ],
            ),

            actions: [
              /// ================= CANCEL =================
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),

              /// ================= SAVE =================
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  foregroundColor: Colors.white,
                ),

               onPressed: ctrl.isCreating
    ? null
    : () async {
        if (!ctrl.notAvailable) {
          if (ctrl.startTime == null || ctrl.endTime == null) {
            Get.snackbar("Error", "Please select start and end time");
            return;
          }
        }

        if (isEdit) {
          await ctrl.updateAvailability(
            availabilityId: availabilityId!,
            doctorId: ctrl.doctorId!,
            weekId: mode == SlotMode.week ? weekId : null,
            date: mode == SlotMode.date ? date : null,
          );
        } else {
          await ctrl.createAvailability(
            doctorId: ctrl.doctorId!,
            weekId: mode == SlotMode.week ? weekId : null,
            date: mode == SlotMode.date ? date : null,
          );
        }

        ctrl.startTime = null;
        ctrl.endTime = null;
        ctrl.notAvailable = false;
        ctrl.update();

        Navigator.of(Get.context!, rootNavigator: true).pop();
      },

                child: ctrl.isCreating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Save"),
              ),
            ],
          );
        },
      );
    },
  );
}
Widget buildTimeSelector({
  required BuildContext context,
  required String label,
  required TimeOfDay? time,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                time == null ? "Select" : time.format(context),
                style: TextStyle(
                  color: AppColors.PrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.access_time_rounded,
                color: AppColors.PrimaryColor,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}