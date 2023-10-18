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

  bool _isBusyEditingGroup = false;
  bool get isBusyEditingGroup => _isBusyEditingGroup;

  List<Group> groups = [];
  List<String> tags = [];

  Future<bool> createGroup(Map<String, dynamic> body) async {
    _isBusy = true;
    _error = "";
    notifyListeners();
    bool result = false;

    final response = await groupRepo.createGroup(body);
    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to create group',
            },
        (r) async => {result = r, groups = await groupRepo.getAllGroups()});
    _isBusy = false;
    notifyListeners();
    return result;
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

  Future<List<GroupTagModel>> getTags() async {
    return await groupRepo.getTags();
  }

  Future<bool> subscribeToGroup(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();
    bool result = false;

    final response = await groupRepo.subscribeToGroup(groupId);

    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to subscribe to group',
            },
        (r) async => {result = r, getGroups()});

    _isBusy = false;
    notifyListeners();
    return result;
  }

  Future<bool> unSubscribeFromGroup(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();
    bool result = false;

    final response = await groupRepo.unSubscribeFromGroup(groupId);

    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to unsubscribe from group',
            },
        (r) async => {result = r, await getGroups()});

    _isBusy = false;
    notifyListeners();
    return result;
  }

  Future<bool> deleteGroup(String groupId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    bool result = false;

    final response = await groupRepo.deleteGroup(groupId);

    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to delete group',
            },
        (r) async => {result = r, await getGroups()});

    _isBusy = false;
    notifyListeners();
    return result;
  }

  Future<bool> editGroupName(
      {required String newGroupName, required String groupID}) async {
    _isBusyEditingGroup = true;
    _error = "";
    notifyListeners();

    bool result = false;

    final response = await groupRepo.editGroupName(
        newGroupName: newGroupName, groupID: groupID);

    response.fold(
        (l) => {
              _error = l.message ?? 'Failed to update group name',
            },
        (r) async => {result = r, await getGroups()});

    _isBusyEditingGroup = false;

    notifyListeners();
    return result;
  }
}

final groupSearchprovider = Provider<List<Group>>((ref) {
  final groups = ref.watch(GroupProvider.groupProvider);
  return groups.groups;
});

final groupTagProvider = FutureProvider<List<GroupTagModel>>((ref) async {
  return await ref.read(GroupProvider.groupProvider).getTags();
});
