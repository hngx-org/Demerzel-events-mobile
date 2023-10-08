import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/repositories/notification_repository.dart';

class NotificationsNotifier extends StateNotifier<NotificationList> {
  NotificationsNotifier() : super(NotificationList.empty());
  NotificationRepository repo = NotificationRepository();

  Future<void> getNotifications() async {
    await repo.getNotifications().then((value) {
      state = NotificationList(notifications: value);
    });
  }

  onread(UserNotification notification) async {
    int index = state.rawNotifications.indexOf(notification);
    state.rawNotifications[index].read = true;
    state = state;
    await repo.updateNotificationRead(notification.id).then((value) => getNotifications());
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationList>(
        (ref) => NotificationsNotifier()
      );

  

class NotificationList {
  final List<UserNotification> rawNotifications;

  NotificationList({required List<UserNotification> notifications})
      : rawNotifications = notifications;
  List<UserNotification> get notifications {
    List<UserNotification> notificationslist =
        rawNotifications.reversed.toList();
    List<UserNotification> readNotifications =
        notificationslist.where((element) => element.read == true).toList();
    List<UserNotification> unreadNotifications =
        notificationslist.where((element) => element.read == false).toList();
    return unreadNotifications + readNotifications;
  }

  NotificationList.empty() : rawNotifications = [];

  // @override
  // List<Object> get props => [];
}
