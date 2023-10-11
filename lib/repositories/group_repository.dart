import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/models/group_tag_model.dart';
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

  Future createGroup(Map<String, dynamic> body) async {
    final header = await authRepository.getAuthHeader();
    log(header.toString());
    final imageUrl = await imageUploadService.uploadImage(body["image"]);
    body["image"] = imageUrl;
    print(body['tags']);
    final response = await apiService.post(
      url: ApiRoutes.groupURI,
      headers: header,
      body: {'name': body['name'], 'image': imageUrl, 'tags': body['tags']},
    );
    log(response.statusCode.toString() + response.reasonPhrase.toString());

    // final result = await apiService.post(
    //   url: ApiRoutes.groupURI,
    //   body: <String, dynamic>{
    //     'name':body['name'],
    //     'image': imageUrl,
    //     'tags': body['tags']
    //   },
    //   headers: header);

    // return true;
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

  Future<void> deleteGroup(String groupId) async {
    final header = await authRepository.getAuthHeader();

    final http.Response response = await apiService.delete(
        url: ApiRoutes.deleteGroupURI(groupId), headers: header);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // log('Group deleted successfully');
      log('Group deleted');
    } else {
      // throw response.reasonPhrase?? response.body;
      // log('Failed to delete event. Status code: ${response.statusCode}');
      log("Group not deleted.");
    }
  }

  Future<void> editGroupName(
      {required String newGroupName, required String groupID}) async {
    final header = await authRepository.getAuthHeader();
    final response = await apiService.put(
      body: {'name': newGroupName},
      headers: header,
      url: ApiRoutes.editGroupURI(groupID),
    );
    log(response.toString());
    if (response['data'] != null) {
      getAllGroups();
    }
  }
}
