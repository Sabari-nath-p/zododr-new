import 'package:flutter/material.dart';

Future<void> showTimeSlotDialog(
  BuildContext context, {
  String title = "Add Time Slot",
}) async {
  TimeOfDay startTime = TimeOfDay.now();

  TimeOfDay endTime = TimeOfDay(
    hour: (TimeOfDay.now().hour + 1) % 24,
    minute: TimeOfDay.now().minute,
  );

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                const Text(
                  "Monday",
                  style: TextStyle(
                    color: Color(0xff1CA7EC),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                buildTimeSelector(
                  context: context,
                  label: "Start Time",
                  time: startTime,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );

                    if (picked != null) {
                      setState(() {
                        startTime = picked;
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),

                buildTimeSelector(
                  context: context,
                  label: "End Time",
                  time: endTime,
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );

                    if (picked != null) {
                      setState(() {
                        endTime = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1CA7EC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Save"),
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
  required TimeOfDay time,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),

          Row(
            children: [
              Text(
                time.format(context),
                style: const TextStyle(
                  color: Color(0xff1CA7EC),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.access_time_rounded,
                color: Color(0xff1CA7EC),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// Delete Dialog
Future<void> showDeleteDialog(
  BuildContext context, {
  VoidCallback? onDelete,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.red.shade600,
            ),
            const SizedBox(width: 8),
            const Text(
              "Delete Time Slot",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: const Text(
          "Are you sure you want to delete this time slot?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onDelete != null) {
                onDelete();
              }
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}