import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/repositories/group_repository.dart';


final groupRepoProvider = Provider((ref) => GroupRepository());


final groupsProvider = FutureProvider<List<Group>>((ref) async {
  try {
    final groupRepo = ref.read(groupRepoProvider);
    
    return groupRepo.getAllGroups(); 
  } catch (e, s) {
    log(e.toString());
    log(s.toString());

    rethrow;
  }
});




// final createGroupProvider = FutureProvider<GetGroupModel>((ref) async {
//   try {
//     final groupRepo = ref.read(groupRepoProvider);
//    // groupRepo.createGroup();
//     return groupRepo.getAllGroups();
//   } catch (e, s) {
//     log(e.toString());
//     log(s.toString());

//     rethrow;
//   }
// });

class CreateGroupHandler extends ChangeNotifier {
  final groupRepo = GroupRepository();


  String _error = "";
  String get error => _error;

  Future<bool> createGroup(String name, File image) async {
    // _isBusy = true;
     _error = "";
    notifyListeners();

    try {
   await groupRepo.createGroup(name, image);
   await groupRepo.getAllGroups();

      // events = result;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
      return false;
    }

    // _isBusy = false;
    notifyListeners();
    return true;
    
  }
}


final createGroupProvider =
    ChangeNotifierProvider<CreateGroupHandler>(
  (ref) => CreateGroupHandler(),
);