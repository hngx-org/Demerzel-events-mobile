import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repository.dart';
import 'user_provider.dart';

class AuthNotifier extends StateNotifier<bool> {
  //if true == authenticated, false == unauthenticated
  AuthNotifier(this.ref) : super (false);

  AuthRepository repo = AuthRepository();
  
  final Ref ref;

  Future signin () async{
    await repo.signin().then(
      (value) {
        state = true;
        ref.read(userProvider.notifier).state = value;
      }
    );
  }

  onLaunch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userTokenExists = prefs.containsKey('userToken');
    String? userToken = prefs.getString('userToken');

    if (userTokenExists) {
      if(JwtDecoder.isExpired(userToken!)){
        // ref.read(userProvider.notifier).state = User.fromJson()
        state = true;
      }
    }
  }
}

  final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) => AuthNotifier(ref));