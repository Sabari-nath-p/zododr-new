import 'dart:async';

import 'package:get/get.dart';
import 'package:zodo_dr/Screens/Notifiactionscreen/Model/NotificationModel.dart';
import 'package:zodo_dr/Utils/apiHandler.dart';

class NotificationController extends GetxController {
  bool isLoading = false;
  bool isFetching = false;

  List<NotificationModel> notifications = [];

  Timer? _timer;

  /// total notifications
  int get notificationCount => notifications.length;

  /// unread badge count (USE THIS FOR BELL ICON)
  int get unreadCount =>
      notifications.where((e) => e.isSeen == false).length;

  @override
  void onInit() {
    super.onInit();

    fetchNotifications();

    /// periodic refresh
    _timer = Timer.periodic(const Duration(seconds: 20), (_) {
      fetchNotifications(showLoader: false);
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// ===============================
  /// FETCH NOTIFICATIONS
  /// ===============================
  Future<void> fetchNotifications({bool showLoader = true}) async {
    if (isFetching) return;
    isFetching = true;

    if (showLoader) {
      isLoading = true;
      update();
    }

    await ApiService.request(
      endpoint: "notifications",
      method: Api.GET,
      onSuccess: (response) {
        final List data = response.data["data"] ?? [];

        notifications =
            data.map((e) => NotificationModel.fromJson(e)).toList();

        isLoading = false;
        isFetching = false;
        update();
      },
      onNetworkError: (_) {
        isLoading = false;
        isFetching = false;
        update();
      },
      onServerError: (_, __) {
        isLoading = false;
        isFetching = false;
        update();
      },
      onUnauthenticated: () {
        isLoading = false;
        isFetching = false;
        update();
      },
      onError: (_) {
        isLoading = false;
        isFetching = false;
        update();
      },
    );
  }

  /// ===============================
  /// REFRESH
  /// ===============================
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }

  /// ===============================
  /// MARK SINGLE AS SEEN
  /// ===============================
  Future<void> markAsSeen(String id) async {
    await ApiService.request(
      endpoint: "notifications/$id/seen",
      method: Api.PATCH,
      onSuccess: (_) {
        final index = notifications.indexWhere((e) => e.id == id);

        if (index != -1) {
          final old = notifications[index];

          notifications[index] = NotificationModel(
            id: old.id,
            userId: old.userId,
            title: old.title,
            body: old.body,
            isSeen: true,
            createdAt: old.createdAt,
            updatedAt: DateTime.now(),
          );
        }

        update();
      },
      onError: (_) {},
    );
  }

  /// ===============================
  /// MARK ALL AS SEEN
  /// ===============================
  Future<void> markAllAsSeen() async {
    await ApiService.request(
      endpoint: "notifications/mark-all-seen",
      method: Api.PATCH,
      onSuccess: (_) {
        notifications = notifications.map((n) {
          return NotificationModel(
            id: n.id,
            userId: n.userId,
            title: n.title,
            body: n.body,
            isSeen: true,
            createdAt: n.createdAt,
            updatedAt: DateTime.now(),
          );
        }).toList();

        update();
      },
      onError: (_) {},
    );
  }
}