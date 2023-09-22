import 'dart:convert';
import 'dart:developer'; 

import '../classes/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  String baseUrl = 'https://api-s65g.onrender.com';

  Future<String> signin () async{
    final response = await http.get(Uri.parse('$baseUrl/oauth/initialize'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['redirectUrl'];
    } else {
      log(response.statusCode.toString());
      throw Exception('failed to initialize auth: ${response.statusCode}');
    }

  }

  Future<User> getUser(String token) async{
    final response = await http.get(Uri.parse('$baseUrl/api/users/current')).catchError((error){
      throw Exception('failed to retrieve User : $error');
    });
    
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to retrieve User : ${response.statusCode}');
    }
  }

  
}