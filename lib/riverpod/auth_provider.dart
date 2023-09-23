import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/screens/event_comment_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';
import '../repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<User?> {
  //if true == authenticated, false == unauthenticated
  AuthNotifier(this.ref) : super (null);

  AuthRepository repo = AuthRepository();
  
  final Ref ref;
  

  setCustomUser(){
    state = User.custom();
  }

  // Future signin (BuildContext context) async{
  //   await repo.signin().then(
  //     (value) async{
        
  //       showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator(),);});
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('userToken', value);
  //       setUser(value);
  //     }
  //   );
  // }

  Future setUser(String token) async{
    repo.getUser(token).then((value) {
      state = value;
    });
  }

  onLaunch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userTokenExists = prefs.containsKey('userToken');
    String? userToken = prefs.getString('userToken');

    if (userTokenExists) {
      if(JwtDecoder.isExpired(userToken!)){
        // ref.read(userProvider.notifier).state = User.fromJson()
        await repo.getUser(userToken);
      }
    }
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = null;
  }
}

  final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier(ref));