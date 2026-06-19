import 'package:flutter/material.dart';


Widget buildDayCard({
  required BuildContext context,
  required String day,
  required List<Widget> timeSlots,
  VoidCallback? onAdd,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        /// Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff1CA7EC).withOpacity(.08),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Color(0xff1CA7EC),
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Slots
        if (timeSlots.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No time slots available",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          )
        else
          Column(children: timeSlots),
      ],
    ),
  );
}

Widget buildTimeSlotTile({
  required String startTime,
  required String endTime,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.access_time_rounded,
          color: Color(0xff1CA7EC),
          size: 20,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            "$startTime - $endTime",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.edit_rounded,
              size: 20,
              color: Colors.blue.shade600,
            ),
          ),
        ),

        const SizedBox(width: 6),

        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.delete_outline_rounded,
              size: 20,
              color: Colors.red.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}