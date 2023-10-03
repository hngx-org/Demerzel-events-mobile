import 'dart:convert';

import 'package:hng_events_app/classes/notification.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  AuthRepository authrepo = AuthRepository(localStorageService: const LocalStorageService());

  Future<List<UserNotification>> getNotifications()async{
    final header = await authrepo.getAuthHeader();
    final response = await http.get(
      Uri.parse('${authrepo.baseUrl}/notifications'),
      headers: header 
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> notificationMap = jsonDecode(response.body);
      List<Map<String, dynamic>> list = notificationMap["data"]["notifications"];

      return list.map((e) => UserNotification.fromJson(e)).toList();

    } else {
      throw Exception('failed to return Notifications ${response.statusCode}');
    }
  }

  Future updateNotificationRead(String id) async{
    final header = await authrepo.getAuthHeader();
    final response = await http.get(
      Uri.parse("${authrepo.baseUrl}/notifications/$id"),
      headers: header  
    );
    if (response.statusCode != 200) {
      throw Exception('failed to update Notifications ${response.statusCode}');
    }
  }
}