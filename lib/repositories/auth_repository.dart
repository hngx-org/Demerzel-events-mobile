import 'dart:convert';
import 'dart:developer'; 

import 'package:google_sign_in/google_sign_in.dart';

import '../classes/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  String baseUrl = 'https://api-s65g.onrender.com';

  Future<String> signin () async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      log(googleAuth.idToken!);
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/verify'),
        body: jsonEncode(
          {
            'token': googleAuth.idToken
          }
        )
      );
      if (response.statusCode == 200) {
        log(jsonDecode(response.body)['data']['token']);
        return jsonDecode(response.body)['data']['token'];
            
      } else {
        log(response.statusCode.toString());
        throw Exception('failed to initialize auth: ${response.statusCode}');
      }

    } else {
      throw Exception('failed to sign in with google: gooogleAuthAccount = null');
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