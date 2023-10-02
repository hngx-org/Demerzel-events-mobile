import 'dart:convert';
import 'dart:developer';
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
    final imageUrl = await imageUploadService.uploadImage(body["image"]);

    body["image"] = imageUrl;
    // body.remove("image");

    // log(body.toString());

    final result =
        apiService.post(url: ApiRoutes.groupURI, body: body, headers: header);
    // log(result.toString());

    return true;
    // try {
    // final jsonData = jsonEncode({
    //   "name": name,
    // });

    // var request = http.MultipartRequest('POST', ApiRoutes.groupURI)
    //   ..fields['jsonData'] = jsonData
    //   ..files.add(await http.MultipartFile.fromPath(
    //     'file',
    //     image.path,
    //   ))
    //   ..headers.addAll(header);

    // var response = await request.send();

    // if (response.statusCode == 200) print('Uploaded!');

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   log(response.statusCode.toString());
    // } else {
    //   return false;
    // }

    //HttpServiceWithDio.uploadImage(url, image);

    //   return true;
    // } catch (e, s) {
    //   log(e.toString());
    //   log(s.toString());
    //   rethrow;
    // }
  }
}
