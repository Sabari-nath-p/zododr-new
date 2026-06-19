
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/AvailabilityCard.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Views/TimeSlotDialogue.dart';

class SCTimeView extends StatelessWidget {
  const SCTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateSlotController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(controller, context),
          
          ],
        );
      },
    );
  }

  // ---------------- DATE ----------------
  Widget _buildDateSection(
    CreateSlotController controller,
    BuildContext context,
  ) {
    final slots = controller.dateAvailabilities;

    return buildDayCard(
      context: context,
      day: DateFormat("dd MMM yyyy").format(controller.selectedDate),

      onAdd: () {
        showTimeSlotDialog(
          context,
          mode: SlotMode.date,
          date: controller.selectedDate,
        );
      },

      timeSlots: _buildSlots(
        controller,
        slots,
        context,
        SlotMode.date,
        null,
      ),
    );
  }

  // ---------------- WEEK ----------------
 

  // ---------------- SLOTS ----------------
  List<Widget> _buildSlots(
    CreateSlotController controller,
    List slots,
    BuildContext context,
    SlotMode mode,
    String? weekId,
  ) {
    return List.generate(slots.length, (index) {
      final slot = slots[index];

     final String id = (slot["id"] ?? "").toString();

      if (slot["not_available"] == true) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Row(
            children: [
              Icon(Icons.block, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Doctor Not Available",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      return buildTimeSlotTile(
        startTime: _formatTime(slot["startTime"]),
        endTime: _formatTime(slot["endTime"]),

        // ---------------- EDIT ----------------
      onEdit: () {
  // 1. PREFILL EXISTING VALUES
  final slot = slots[index];

  controller.startTime = _parseTime(slot["startTime"]);
  controller.endTime = _parseTime(slot["endTime"]);
  controller.notAvailable = slot["not_available"] ?? false;

  controller.update();

  // 2. OPEN DIALOG
  showTimeSlotDialog(
    context,
    mode: mode,
    weekId: weekId,
    date: controller.selectedDate,
    isEdit: true,
    availabilityId: id,
  );
},

        // ---------------- DELETE (FIXED) ----------------
        onDelete: () {
  showDeleteDialog(
    context,
    onDelete: () {
      controller.deleteAvailability(
        availabilityId: id,
        weekId: weekId, // null for date mode, value for week mode
      );
    },
  );
},
      );
    });
  }

  // ---------------- TIME FORMAT ----------------
  static String _formatTime(String? value) {
    if (value == null || value.isEmpty) return "--";

    for (final format in ["HH:mm:ss", "HH:mm"]) {
      try {
        final date = DateFormat(format).parse(value);
        return DateFormat("hh:mm a").format(date);
      } catch (_) {}
    }

    return value;
  }
}

/// ================= DELETE DIALOG =================
void showDeleteDialog(
  BuildContext context, {
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Slot"),
        content: const Text("Are you sure you want to delete this time slot?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
TimeOfDay _parseTime(String? value) {
  if (value == null || value.isEmpty) return TimeOfDay.now();

  try {
    final parts = value.split(":");
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  } catch (_) {
    return TimeOfDay.now();
  }
}