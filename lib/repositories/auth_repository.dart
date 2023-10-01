import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepository {
  final LocalStorageService localStorageService;

  AuthRepository({required this.localStorageService});
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static const _user = 'userToken';
  String baseUrl = ApiRoutes.baseUrl;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> signUpUserInBackend(String token) async {
    final body = jsonEncode({
      "token": token,
    });

    final response = await http.post(
      ApiRoutes.authGoogleURI,
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['data']['token'];
      await saveToken(token);
    }

    final authHeader = await getAuthHeader();
    print(authHeader);
  }

  Future<User?> getUser() async {
    return auth.currentUser;
  }

  Future<void> saveToken(String token) async {
    await localStorageService.saveToDisk(_user, token);
  }

  Future<String> getToken() async {
    final token = await localStorageService.getFromDisk(_user) as String?;
    if (token != null) {
      return token;
    } else {
      throw Exception('Failed to retrieve token');
    }
  }

  Future<Map<String, String>> getAuthHeader() async {
    final token = await getToken();
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<String> getUserid() async{
    String token = await getToken();
    Map<String, dynamic> userMap = JwtDecoder.decode(token);
      return userMap["data"]["id"];
  }

  Future updateUserProfile(String userName, String image) async{
    String userid = await getUserid();
    String userToken = await getToken();
    Map<String, String> headerMap = await getAuthHeader();
    // header = Headers.fromMap(headerMap)
    final response = await http.put(
      Uri.parse('$baseUrl/api/users/$userToken'),
      headers: headerMap,
      body: jsonEncode(<String, String>
        {
          'name': userName,          
        }
      )
    );
    if (response.statusCode != 200) {
      throw Exception("failed to update userProfile");
    }
  }

  Future<void> removeToken() async {
    await localStorageService.removeFromDisk(_user);
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
    await removeToken();
  }

  static final provider = Provider<AuthRepository>((ref) => AuthRepository(
      localStorageService: ref.read(LocalStorageService.provider)));
}
