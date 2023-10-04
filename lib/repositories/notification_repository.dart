import 'dart:convert';

import 'package:hng_events_app/models/notification.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  AuthRepository authrepo = AuthRepository(localStorageService: const LocalStorageService());

  Future<List<UserNotification>> getNotifications()async{
    final header = await authrepo.getAuthHeader();
    final response = await http.get(
      ApiRoutes.notificationURI,
      headers: header 
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> notificationMap = jsonDecode(response.body);
      List<dynamic> list = notificationMap["data"]["notifications"];
      // log(notificationMap.toString());

      return list.map((e) => UserNotification.fromJson(e)).toList();

    } else {
      throw Exception('failed to return Notifications ${response.statusCode}');
    }
  }

  Future<void> updateNotificationRead(String id) async{
    final header = await authrepo.getAuthHeader();
    final response = await http.get(
      Uri.parse("${ApiRoutes.notificationURI}/$id"),
      headers: header  
    );
    if (response.statusCode != 200) {
      throw Exception('failed to update Notifications ${response.statusCode}');
    }
  }
}