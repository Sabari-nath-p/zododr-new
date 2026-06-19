import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/CreateSlotScreen/Controller/CSController.dart';
import 'package:zodo_dr/Utils/appText.dart';

class SCCalenderCard extends StatelessWidget {
  SCCalenderCard({super.key});
  CreateSlotController ctrl = Get.put(CreateSlotController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393.w,
      height: 307.h,
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: appText.primaryText(
                text: "Select Date",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          // Expanded(
          //   child: GetBuilder<CSController>(builder: (_) {
          //     return Container(
          //       width: 370.w,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12),
          //           color: Color(0xffF9FAFB)),
          //       height: 260.h,
          //       margin: EdgeInsets.all(16.w),
          //       padding: EdgeInsets.all(12.w),
          //       child: SfCalendar(
          //         view: CalendarView.month,
          //         headerStyle: CalendarHeaderStyle(
          //             backgroundColor: Color(0xffF9FAFB),
          //             textStyle: GoogleFonts.lato(
          //                 fontSize: 14.sp, fontWeight: FontWeight.w700)),
          //         selectionDecoration: BoxDecoration(),
          //         showNavigationArrow: true,
          //         onTap: (calendarTapDetails) {
          //           if (_.selectedDate.contains(calendarTapDetails.date)) {
          //             _.selectedDate.remove(calendarTapDetails.date);
          //           } else {
          //             _.selectedDate.add(calendarTapDetails.date!);
          //           }
          //           _.update();
          //         },
          //         monthCellBuilder: (context, details) => Container(
          //           alignment: Alignment.center,
          //           child: Container(
          //             width: 36.w,
          //             height: 30.h,
          //             alignment: Alignment.center,
          //             decoration: (!_.selectedDate.contains(details.date))
          //                 ? null
          //                 : BoxDecoration(
          //                     borderRadius: BorderRadius.circular(8),
          //                     color: appColor.primaryColor),
          //             margin: EdgeInsets.only(top: 5.h),
          //             child: appText.primaryText(
          //                 text: DateFormat("dd").format(
          //                   details.date,
          //                 ),
          //                 color: (!_.selectedDate.contains(details.date))
          //                     ? Color(0xff6B7280)
          //                     : Colors.white,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 12.sp),
          //           ),
          //         ),
          //       ),
          //     );
          //   }),
          // )
        ],
      ),
    );
  }
}