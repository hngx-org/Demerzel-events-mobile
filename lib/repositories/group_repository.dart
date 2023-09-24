import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

class GroupRepository {
  final AuthRepository authRepository;
  GroupRepository({required this.authRepository});

  static final provider = Provider<GroupRepository>((ref) {
    final authRepository = ref.read(AuthRepository.provider);
    return GroupRepository(authRepository: authRepository);
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

  Future<bool> createGroup(String name, File image) async {
    final header = await authRepository.getAuthHeader();

    try {
      final jsonData = jsonEncode({
        "name": name,
      });

      var request = http.MultipartRequest('POST', ApiRoutes.groupURI)
        ..fields['jsonData'] = jsonData
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          image.path,
        ))
        ..headers.addAll(header);

      var response = await request.send();

      if (response.statusCode == 200) print('Uploaded!');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusCode.toString());
      } else {
        return false;
      }

      //HttpServiceWithDio.uploadImage(url, image);

      return true;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
