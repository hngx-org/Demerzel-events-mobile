import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({
    required this.authRepository,
  }) {
    getUser();
  }
  final AuthRepository authRepository;

  User? user;
  updateUserProfile(String username, String image) async{
    await authRepository.updateUserProfile(
      username, 
      ''
    );
  }

  Future<void> getUser() async {
    user = await authRepository.getUser();
    notifyListeners();
  }

  static final notifier = ChangeNotifierProvider<UserProvider>((ref) =>
      UserProvider(authRepository: ref.watch(AuthRepository.provider)));
}

