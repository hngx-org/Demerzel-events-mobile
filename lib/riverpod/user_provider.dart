import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/user.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';

class UserNotifier extends StateNotifier<AppUser?> {
  UserNotifier(this.repo) : super(null) {
    getUserBE();
  }
  final AuthRepository repo;
  bool _preventLoop = false;

  Future getUserLocal() async {
    await repo.getUserLocal().then((value) => state = value);
  }

  Future getUserInit() async {
    if (!_preventLoop) {
      await repo.getUserLocal().then((value) => state = value);
      _preventLoop = true;
    }
  }

  Future<void> getUserBE() async {
    await repo.getAppUserBE().then((value) => state = value);
  }

  Future<String?> updateUserProfile(String username, File? file) async {
    String? error;
    final response = await repo.updateUserProfile(
      file,
      username,
    );

    response.fold(
        (l) => {
              error = l.message ?? 'Failed to update profile',
            },
        (r) => {
              getUserBE(),
            });

    return error;
  }

  Future siginInWithGoogle() async {
    final token = await repo.signInWithGoogle();
    await repo.signUpUserInBackend(token);
    await getUserLocal();
  }

  Future signOut() async {
    await repo.signOut().then((value) => state = null);
  }
}

final appUserProvider = StateNotifierProvider<UserNotifier, AppUser?>(
    (ref) => UserNotifier(ref.read(AuthRepository.provider)));
