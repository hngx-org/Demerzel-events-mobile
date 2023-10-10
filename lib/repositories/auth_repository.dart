import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/user.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:googleapis/calendar/v3.dart';
final GoogleSignIn googleSignIn = GoogleSignIn(scopes:  [CalendarApi.calendarScope]);

class AuthRepository {
  final LocalStorageService localStorageService;
  

  AuthRepository({required this.localStorageService});
  FirebaseAuth auth = FirebaseAuth.instance;
  
  static const _user = 'userToken';
  String baseUrl = ApiRoutes.baseUrl;
  

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
 
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      String token = await auth.signInWithCredential(credential).then(
        (value) async {
          final token = await value.user?.getIdToken();
          if (token != null) {
            return token;
            // signUpUserInBackend(token);
          } else{
            throw Exception('Failed to retrieve token from Google');
          }
        },
       
      ).catchError(
        (error){
          throw Exception('signInWithCredential Failed ');
        }
      );
      return token;
      
    }else { throw Exception('failed to retrieve Token null');}
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
      await localStorageService.saveToDisk(_user, token);
    }

    final authHeader = await getAuthHeader();
    print(authHeader);
  }

  Future<User?> getUser() async {
    return auth.currentUser;
  }

  Future<AppUser?> getAppUserBE() async{
    var header = await getAuthHeader();
    final response = await http.get(
      ApiRoutes.currentUserURI, 
      headers: header,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> listUsers = jsonDecode(response.body);
      return AppUser.fromJson(listUsers);
    } else {
      throw Exception('Failed to retrieve User ${response.statusCode}');
    }
  }

  Future<void> saveToken(String token) async {
    await localStorageService.saveToDisk(_user, token);
  }

  Future<String?> getToken() async {
    final token = await localStorageService.getFromDisk(_user) as String?;
    return token;
 
  }

  Future<Map<String, String>> getAuthHeader() async {
    final token = await getToken();
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<String> getUserid() async{
    String? token = await getToken();
    Map<String, dynamic> userMap = JwtDecoder.decode(token!);
      return userMap["data"]["id"];
  }

  Future<AppUser> getUserLocal() async {
    String? token = await getToken();
    if (token != null) {
     Map<String, dynamic> userMap = JwtDecoder.decode(token); 
     return AppUser.fromJson(userMap);
    } else {
      throw Exception('User Token Local null');
    }
    
    
  }

  Future updateUserProfile(String userName) async{
    String userid = await getUserid();
    Map<String, String> headerMap = await getAuthHeader();
    final response = await http.put(
      Uri.parse('$baseUrl/users'),
      headers: headerMap,
      body: jsonEncode(<String, String>
        {
          'name': userName,          
        }
      )
    );
    if (response.statusCode != 200) {
      throw Exception("failed to update userName");
    }
  }

  Future<String> getimageUrl(File file) async{
    Map<String, String> headerMap = await getAuthHeader();
    final request = http.MultipartRequest('POST', ApiRoutes.imageUploadURI)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          file.path,
        ))
        ..headers.addAll(headerMap);
      final response = await request.send();
    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      Map<String, dynamic> mapdata = jsonDecode(responseJson);
      return mapdata['data']["url"];
    } else {
      throw Exception("failed to get imageUrl ${response.statusCode}");
    }
  }

  Future updateProfilePhoto(File imageFile) async{
    String userid = await getUserid();
    String imageUrl = await getimageUrl(imageFile);
    Map<String, String> headerMap = await getAuthHeader();
    final response = await http.put(
      Uri.parse('$baseUrl/users'),
      headers: headerMap,
      body: jsonEncode(<String, dynamic>
        {
          'avatar': imageUrl,          
        }
      )
    );
    if (response.statusCode != 200) {
      throw Exception("failed to update userPhoto ${response.statusCode}");
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
