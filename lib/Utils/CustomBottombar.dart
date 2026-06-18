// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// Widget customBottomBar({int selected = 0}) {
//   return Container(
//     width: 360.w,
//     height: 70.h,
//     margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 22.h),
//     padding: EdgeInsets.symmetric(horizontal: 26.5.w),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(18.r),
//       color: Color(0xff212226),
//       boxShadow: [
//         BoxShadow(
//           offset: Offset(0, 17),
//           blurRadius: 32,
//           spreadRadius: 0,
//           color: Colors.black.withOpacity(.5),
//         ),
//       ],
//     ),
//     child: Row(
//       spacing: 21.w,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Homecontroller hmctrl = Get.put(Homecontroller());
//             hmctrl.selectedMenu = 0;
//             hmctrl.update();
//           },
//           child: Image.asset(
//             "Assets/Icons/home_icon.png",
//             color: (selected == 0) ? Color.fromARGB(255, 0, 255, 4) : null,
//             height: 40.h,
//             width: 60.w,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Homecontroller hmctrl = Get.put(Homecontroller());
//             hmctrl.selectedMenu = 1;
//             hmctrl.update();
//           },
//           child: Image.asset(
//             "Assets/Icons/booking_icon.png",
//             color: (selected == 1) ? Color.fromARGB(255, 0, 255, 4) : null,
//             height: 40.h,
//             width: 60.w,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Homecontroller hmctrl = Get.put(Homecontroller());
//             hmctrl.selectedMenu = 2;
//             hmctrl.update();
//           },
//           child: Image.asset(
//             "Assets/Icons/zodoai_icon.png",
//             color: (selected == 2) ? Color.fromARGB(255, 0, 255, 4) : null,
//             height: 40.h,
//             width: 60.w,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Homecontroller hmctrl = Get.put(Homecontroller());
//             hmctrl.selectedMenu = 3;
//             hmctrl.update();
//           },
//           child: Image.asset(
//             "Assets/Icons/notification_icon.png",
//             color: (selected == 3) ? Color.fromARGB(255, 0, 255, 4) : null,
//             height: 40.h,
//             width: 60.w,
//           ),
//         ),
//       ],
//     ),
//   );
// }
