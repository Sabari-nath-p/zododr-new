import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zodo_dr/Screens/Notifiactionscreen/Service/NotiificationController.dart';
import 'package:zodo_dr/Screens/Notifiactionscreen/Views/NotiifcationAppBar.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller =
    Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      body: Column(
        children: [
           NotificationAppBar(),

          Expanded(
            child: GetBuilder<NotificationController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.notifications.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 70.sp,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "No Notifications",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "You're all caught up.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshNotifications,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    itemCount: controller.notifications.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final notification = controller.notifications[index];

                      return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48.w,
                              width: 48.w,
                              decoration: BoxDecoration(
                                color: const Color(0xffEDF4FF),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: const Icon(
                                Icons.notifications_active_rounded,
                                color: Color(0xff3478F6),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notification.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      if (!notification.isSeen)
                                        Container(
                                          width: 10.w,
                                          height: 10.w,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    notification.body,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade700,
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    DateFormat("dd MMM yyyy • hh:mm a")
                                        .format(notification.createdAt.toLocal()),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}