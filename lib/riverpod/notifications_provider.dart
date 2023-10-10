import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/repositories/notification_repository.dart';

class NotificationsNotifier extends StateNotifier<NotificationList> {
  NotificationsNotifier({required this.repo}) : super(NotificationList.empty());
  
final NotificationRepository repo;


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
        (ref) => NotificationsNotifier(repo: ref.read(NotificationRepository.provider))
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


 class NotificationSettingsPrefsNotifier extends ChangeNotifier {
  final NotificationRepository notificationRepository;
  NotificationSettingsPrefsNotifier({required this.notificationRepository}){
    getPrefs();
  }

   static final provider = ChangeNotifierProvider<NotificationSettingsPrefsNotifier>((ref) {
    return NotificationSettingsPrefsNotifier(notificationRepository: ref.read(NotificationRepository.provider));
  });

NotificationPrefs? notificationPrefs;
bool event = true;
bool group = true;
bool reminders = true;
bool email = true;
  String _error = "";
  String get error => _error;

  bool _isBusy = false;
    Future<NotificationPrefs?> getPrefs() async {
    _isBusy = true;
    _error = "";
    notifyListeners();
     notificationPrefs = await notificationRepository.getNotificationPrefs(); 
    event = notificationPrefs!.event;
    email = notificationPrefs!.email;
    group = notificationPrefs!.group;
    reminders = notificationPrefs!.reminder;
    notifyListeners();
    _isBusy = false;
    notifyListeners();
    return notificationPrefs;
  }


   Future<NotificationPrefs?> updatePrefs(Map<String, dynamic> body) async {
    _isBusy = true;
    _error = "";
    notifyListeners();
     notificationPrefs = await notificationRepository.updateNotificationPrefs(body); 
    
    notifyListeners();
    _isBusy = false;
    notifyListeners();
    return notificationPrefs;
  }
}