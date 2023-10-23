import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/http_service/api_service.dart';

class NotificationRepository {
  final AuthRepository authRepo;
  final ApiService apiService;

  NotificationRepository({required this.apiService, required this.authRepo});

  static final provider =
      Provider<NotificationRepository>((ref) => NotificationRepository(
            authRepo: ref.read(AuthRepository.provider),
            apiService: ref.read(ApiServiceImpl.provider),
          ));

  Future<List<UserNotification>> getNotifications() async {
    final header = await authRepo.getAuthHeader();
    final result = await apiService.get(
      headers: header,
      url: ApiRoutes.notificationURI,
    );
    if (result['status'] == 'success')  {
      //Map<String, dynamic> notificationMap = jsonDecode(response.body);
      List<dynamic> list = result["data"]["notifications"];
      // log(notificationMap.toString());

      return list.map((e) => UserNotification.fromJson(e)).toList();
    } else {
      throw Exception('Failed to return Notifications ');
    }
  }

  // Future<void> updateNotificationRead(List ids) async {
  //   final header = await authRepo.getAuthHeader();
  //   final response = await apiService
  //       .put(url: Uri.parse("${ApiRoutes.notificationURI}/"), headers: header, body: {"read": true, 'notification_ids':ids});
  //   if (response.statusCode != 200) {
  //     throw Exception('failed to update Notifications ${response.statusCode}');
  //   }
  // }

   Future<void> updateNotificationRead(String id) async {
    final header = await authRepo.getAuthHeader();
    final response = await apiService
        .put(url: Uri.parse("${ApiRoutes.notificationURI}/$id"), headers: header, body: {"read": true});
    if (response.statusCode != 200) {
      throw Exception('failed to update Notifications ${response.statusCode}');
    }}

  Future<NotificationPrefs?> getNotificationPrefs() async {
    final header = await authRepo.getAuthHeader();

    final result = await apiService.get(
     
      headers: header,
      url: ApiRoutes.notificationPrefsURI,
    );
    if (result['status'] == 'success') {
     
      return  NotificationPrefs.fromJson(result);
    } else {
      return null;
    }
  }
 Future<NotificationPrefs?> updateNotificationPrefs(Map<String, dynamic> body) async {
    final header = await authRepo.getAuthHeader();

    final result = await apiService.put(
     body: body,
      headers: header,
      url: ApiRoutes.notificationPrefsURI,
    );
    if (result['status'] == 'success') {
     
      return  NotificationPrefs.fromJson(result);
    } else {
      return null;
    }
  }
  //   Future fetchNotifications() async {
  //   AppHttpResponse response = await HttpService.get(
  //       path:
  //           '${HttpService.users}/${_authRepository.userData?.id}/${HttpService.notifications}',
  //       params: {});
  //   if (response.error || response.data == null) return;

  //   _userNotifications = List.from(response.data)
  //       .map<UserNotifications>((e) => UserNotifications.from(e))
  //       .toList();

  //   getUnreadNotificationIds();
  // }

  // Future<bool> updateNotifications(String ids) async {
  //   AppHttpResponse response = await HttpService.patch(
  //       '${HttpService.notifications}/${ids}', {'read': true});
  //   return !response.error;
  // }

  // void getUnreadNotificationIds() {
  //   if (_unreadNotifications.isNotEmpty) {
  //     for (int i = 0; i < _unreadNotifications.length; i++) {
  //       if (_unreadNotificationIds
  //               .contains(_unreadNotifications[i].id.toString()) ==
  //           false) {
  //         _unreadNotificationIds.add(_unreadNotifications[i].id.toString());
  //       }
  //     }
  //   } else
  //     _unreadNotifications
  //         .addAll(_userNotifications.where((element) => element.read == false));
  //   for (int i = 0; i < _unreadNotifications.length; i++) {
  //     if (_unreadNotificationIds
  //             .contains(_unreadNotifications[i].id.toString()) ==
  //         false) {
  //       _unreadNotificationIds.add(_unreadNotifications[i].id.toString());
  //     }
  //   }
  //   print('${_unreadNotifications} & ${_unreadNotifications.length}');
  // }

  // setReadNotificationIds(String ids) {
  //   _readNotificationIds = ids;
  //   print('set readIds = ${_readNotificationIds}');
  // }
}
