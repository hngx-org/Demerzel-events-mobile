import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final LocalStorageService localStorageService;

  AuthRepository({required this.localStorageService});

  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        final token = await userCredential.user!.getIdToken();

        print('----> Firebase token: $token');

        await signUpUserInBackend('Bearer $token');
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> signUpUserInBackend(String token) async{
   final response = await http.post(
      ApiRoutes.authGoogleURI,
     body: {
        'token': token,
     }
    );

    print(response.body);

    
  }

  Future<User> getUser() async {
    return auth.currentUser!;
  }

  static const _user = 'userToken';

  Future<void> saveToken(String token) async {
    await localStorageService.saveToDisk(_user, token);
  }

  Future<String?> getToken() async {
    final token = await localStorageService.getFromDisk(_user) as String?;
    return 'Bearer $token';
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
