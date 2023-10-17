import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/models/group_tag_model.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/http_service/api_service.dart';
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
      final result =
          await apiService.get(url: ApiRoutes.groupURI, headers: header);

      return result['data']['groups'] == null
          ? []
          : List<Group>.from(
              result['data']['groups'].map((x) => Group.fromJson(x)));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future createGroup(Map<String, dynamic> body) async {
    final header = await authRepository.getAuthHeader();

    final imageUrl = await imageUploadService.uploadImage(body["image"]);
    body["image"] = imageUrl;

    final response = await apiService.post(
      url: ApiRoutes.groupURI,
      headers: header,
      body: {'name': body['name'], 'image': imageUrl, 'tags': body['tags']},
    );
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

  Future<List<GroupTagModel>> getTags() async {
    final header = await authRepository.getAuthHeader();
    final response = await http.get(
      Uri.parse("${ApiRoutes.baseUrl}/tags"),
      headers: header,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return (jsonDecode(response.body)['data']['tags'] as List)
          .map((e) => GroupTagModel.fromJson(e))
          .toList();
    } else {
      throw Exception('failed to retrieve tags ${response.statusCode}');
    }
  }

  Future<bool> deleteGroup(String groupId) async {
    final header = await authRepository.getAuthHeader();
    // ignore: avoid_print
    print(header);
    //  final response = await http.delete(
    //   ApiRoutes.deleteGroupURI(groupId),
    //   headers: header,
    // );
    final response = await apiService.delete(
        url: ApiRoutes.deleteGroupURI(groupId), headers: header);

    if (response is DioException) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> editGroupName(
      {required String newGroupName, required String groupID}) async {
    final header = await authRepository.getAuthHeader();
    final response = await apiService.put(
      body: {'name': newGroupName},
      headers: header,
      url: ApiRoutes.editGroupURI(groupID),
    );
    if (response is DioException) {
      return false;
    } else {
      if (response['data'] != null) {
        getAllGroups();
      } else {
        return false;
      }
      return true;
    }
  }
}
