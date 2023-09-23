import 'dart:convert';
import 'dart:developer';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/chat.dart';
import 'package:http/http.dart' as http;



class CommentRepository{
   Future<Comment> sendComment() async {
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

    try {
      final http.Response response = await http
          .post(Uri.parse('${ApiRoutes.baseUrl}/api/comments/'), headers: header)
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        return Comment.fromJson(data);
      } else {
        throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  } Future<Comment> getComments() async {
    final header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoib2xhbWlsZWthbmx5NjZAZ21haWwuY29tIiwiaWQiOiJhNmQwZjViZi1iOTIzLTQ3YTUtODQwNi03NDY1NTFkY2EzOTUiLCJuYW1lIjoiT2xhbWlsZWthbiBBZGVsZWtlIn0sImV4cCI6MTY5NTYzNjA4MH0.Rjr1FbwX0jFJ7y4OxVjwVhCq3XxuspHW1dezRuxAsjg"
    };

    try {
      final http.Response response = await http
          .get(Uri.parse('${ApiRoutes.baseUrl}/api/comments/'), headers: header)
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        return Comment.fromJson(data);
      } else {
        throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

}