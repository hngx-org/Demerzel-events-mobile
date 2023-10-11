import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/models/group_tag_model.dart';
import 'package:hng_events_app/repositories/group_repository.dart';

class GroupProvider extends ChangeNotifier {
  final GroupRepository groupRepo;
  GroupProvider({required this.groupRepo}) {
    getGroups();
  }

  static final groupProvider = ChangeNotifierProvider<GroupProvider>(
    (ref) => GroupProvider(
      groupRepo: ref.read(GroupRepository.provider),
    ),
  );

  String _error = "";
  String get error => _error;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  List<Group> groups = [];
  List<String> tags = [];

  Future<bool> createGroup(Map<String, dynamic> body) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await groupRepo.createGroup(body);
      groups = await groupRepo.getAllGroups();
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

  Future<void> getGroups() async {
    _isBusy = true;
    _error = "";
    notifyListeners();
    try {
      final result = await groupRepo.getAllGroups();
      groups = result;
      notifyListeners();
    } catch (e, s) {
      _isBusy = false;
      _error = e.toString();
      log(e.toString());
      log(s.toString());
      
      notifyListeners();
      rethrow;
    }
    _isBusy = false;
    notifyListeners();
  }

  Future<List<GroupTagModel>> getTags() async{
    return await groupRepo.getTags();
    
  }

  Future<bool> subscribeToGroup(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await groupRepo.subscribeToGroup(groupId);
      await getGroups();
      notifyListeners();
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

    Future<bool> unSubscribeFromGroup(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await groupRepo.unSubscribeFromGroup(groupId);
      await getGroups();
      notifyListeners();
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
}

final groupSearchprovider = Provider<List<Group>>((ref) {
  final groups = ref.watch(GroupProvider.groupProvider);
  return groups.groups;
});

final groupTagProvider = FutureProvider<List<GroupTagModel>>((ref) async{
  return await ref.read(GroupProvider.groupProvider).getTags();
});