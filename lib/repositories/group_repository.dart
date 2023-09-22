import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hng_events_app/models/group.dart';
import 'package:http/http.dart' as http;

class GroupRepository1 {
  // List<Group> groups = [];

  createGroup(Group group) async {
    // AppHttpResponse response = await HttpServiceWithDio.post(
    //     path: HttpServiceWithDio.createGroup, data: {"Name": group.name});
    // if (response.error) {
    //   return;
    // }
    // {
    //   await getGroups();
    // }
    // _groups.add(group);
    // await getGroups();
    // return _groups;

    //await Future.delayed(Duration(seconds: 2));
    mockGroups.add(group);
    getGroups();
  }

  getGroups() async {
    // AppHttpResponse response = await HttpServiceWithDio.get(
    //     path: HttpServiceWithDio.getGroups, params: {});
// groups =
//         List.from(response.data).map((e) => Group.fromJson(e)).toList();
    return mockGroups;
  }

  uploadImage(image) async {
//   AppHttpResponse response = await HttpServiceWithDio.post(path:HttpServiceWithDio.upload,data: {
//       'file': image,
//     });

// _imageUrl = response.data;
  }
}

class GroupRepository {
  Future<GetGroupModel> getAllGroups() async {
    const String url = "https://api-s65g.onrender.com/api/groups";
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

    try {
      final http.Response response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        return GetGroupModel.fromMap(data);
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
    const String url = "https://api-s65g.onrender.com/api/groups";
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

    //log(body.toString());

    try {
      // final http.Response response = await http
      //     .post(Uri.parse(url), headers: header, body: json.encode(body))
      //     .timeout(const Duration(seconds: 60));

      var uri = Uri.https(url, 'create');
      var request = http.MultipartRequest('POST', uri)
        ..fields['name'] = name
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
        ));
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

List<Group> mockGroups = [
  Group(
      name: 'Techies',
      groupImage: 'assets/illustrations/techies_illustration.png'),
  Group(
      name: 'YBNL MAFIA',
      groupImage: 'assets/illustrations/dancers_illustration.png'),
];
