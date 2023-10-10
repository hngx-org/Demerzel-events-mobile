import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/api_service.dart';
import 'package:hng_events_app/services/http_service/image_upload_service.dart';
import 'package:http/http.dart' as http;

class GroupRepository {
  final AuthRepository authRepository;
  final ImageUploadService imageUploadService;
  final ApiService apiService;
  GroupRepository(
      {required this.authRepository,
      required this.imageUploadService,
      required this.apiService});

  static final provider = Provider<GroupRepository>((ref) {
    return GroupRepository(
        authRepository: ref.read(AuthRepository.provider),
        apiService: ref.read(ApiServiceImpl.provider),
        imageUploadService: ref.read(ImageUploadService.provider));
  });

  Future<List<Group>> getAllGroups() async {
    final header = await authRepository.getAuthHeader();

    try {
      final http.Response response = await http
          .get(ApiRoutes.groupURI, headers: header)
          .timeout(const Duration(seconds: 60));

      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        GroupListModel groupListModel = GroupListModel.fromJson(data);
        return groupListModel.groups;
      } else {
        throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future<bool> createGroup(Map<String, dynamic> body) async {
    final header = await authRepository.getAuthHeader();
    log(header.toString());
    final imageUrl = await imageUploadService.uploadImage(body["image"]);

    body["image"] = imageUrl;
    // body.remove("image");

    // log(body.toString());

    final result = await apiService.post(
        url: ApiRoutes.groupURI, body: body, headers: header);
    // log(result.toString());

    return true;
  }

  Future<bool> subscribeToGroup(String groupId) async {
    final header = await authRepository.getAuthHeader();

    final result = await apiService.post(
        url: ApiRoutes.subscribeToGroupURI(groupId), body: {}, headers: header);

    if (result['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unSubscribeFromGroup(String groupId) async {
    final header = await authRepository.getAuthHeader();

    final result = await apiService.post(
        url: ApiRoutes.unSubscribeFromGroupURI(groupId),
        body: {},
        headers: header);
    if (result['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteGroup(String groupId) async {
    final header = await authRepository.getAuthHeader();
    final apiUrl = ApiRoutes.deleteGroupURI(groupId).toString();
    final url = Uri.parse(apiUrl);
    final http.Response response = await http
        .delete(url, headers: header)
        .timeout(const Duration(seconds: 60));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // log('Group deleted successfully');
      print('Group deleted');
    } else {
      // throw response.reasonPhrase?? response.body;
      // log('Failed to delete event. Status code: ${response.statusCode}');
      print("Group not deleted.");
    }
  }

  Future<void> editGroupName({required String newGroupName, required String groupID}) async {
    final header = await authRepository.getAuthHeader();
    //final apiUrl = ApiRoutes.editGroupURI(groupID);
    // final url = Uri.parse(apiUrl);
    final http.Response response = await apiService
        .put(
           body: {
            'name':newGroupName
           },
          headers: header, url: ApiRoutes.editGroupURI(groupID),
        )
        .timeout(const Duration(seconds: 60));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Group Name updated");
      
    } else {
      print("group Name not updated");
    }
  }
}
