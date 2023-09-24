import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/repositories/group_repository.dart';

class CreateGroupHandler extends ChangeNotifier {
  final GroupRepository groupRepo;
  CreateGroupHandler({required this.groupRepo}){
   groupsProvider();
  }

  String _error = "";
  String get error => _error;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  List<Group> groups = [];

  Future<bool> createGroup(String name, File image) async {
     _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await groupRepo.createGroup(name, image);
      await groupRepo.getAllGroups();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
      return false;
    }

     _isBusy = false;
    notifyListeners();
    return true;
  }

  Future<void> groupsProvider() async {
    _isBusy = true;
    _error = "";
     notifyListeners();
    try {
      final result = await groupRepo.getAllGroups();
      groups = result;
      notifyListeners();
    } catch (e, s) {
      _error = e.toString();
      log(e.toString());
      log(s.toString());

      rethrow;
    }
    _isBusy =false;
    notifyListeners();
  }
}

final groupProvider = ChangeNotifierProvider<CreateGroupHandler>(
  (ref) => CreateGroupHandler(
    groupRepo: ref.read(GroupRepository.provider),
  ),
);
