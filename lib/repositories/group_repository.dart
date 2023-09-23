import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:http/http.dart' as http;

class GroupRepository {
  List<Group> _groups = [];
  List<Group> get groups => _groups;

  Future<List<Group>> getAllGroups() async {
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

    try {
      final http.Response response = await http
          .get(ApiRoutes.groupURI, headers: header)
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        GroupListModel groupListModel = GroupListModel.fromJson(data);
        _groups = groupListModel.groups;
        return _groups;
        //GetGroupModel.fromMap(data);
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
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

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
      print('----> I don fail ooo...: ${e.toString()}');

      rethrow;
    }
  }
}

// List<Group> mockGroups = [
//   Group(
//       name: 'Techies',
//       groupImage: 'assets/illustrations/techies_illustration.png'),
//   Group(
//       name: 'YBNL MAFIA',
//       groupImage: 'assets/illustrations/dancers_illustration.png'),
// ];
