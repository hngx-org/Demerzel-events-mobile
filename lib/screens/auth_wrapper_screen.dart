import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/screens/screen_util.dart';
import 'package:hng_events_app/screens/signin_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.watch(AuthRepository.provider);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return FutureBuilder<String>(
            future: _getIdTokenAndSignUp(snapshot.data!, authRepo),
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.connectionState == ConnectionState.done) {
                return const ScreenUtilInitScreen();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        } else {
          return const SignIn();
        }
      },
    );
  }

  Future<String> _getIdToken(User user) async {
    final idTokenResult = await user.getIdToken();
    return idTokenResult??'';
  }

  Future<String> _getIdTokenAndSignUp(User user, AuthRepository authRepo) async {
    final backendToken = await authRepo.getToken();
    log(backendToken.toString());
    if (backendToken != null) {
      return backendToken;
    }

    final token = await _getIdToken(user);
    await authRepo.signUpUserInBackend(token);
    return token;
  }
}
