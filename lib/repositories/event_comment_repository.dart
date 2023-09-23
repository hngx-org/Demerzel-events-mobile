import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class EventCommentRepository {
  String baseUrl = 'https://api-s65g.onrender.com';

  Future<Map<String, List>> getComments()async{
    return await Future.delayed(const Duration(seconds: 10)).then((value) {
      return {
        "data": [
          {"comment" : "what's up!.. Would def. be there for sure!"},
          {"comment" : "what's up!.. Would def. be there for sure!"},
          {"comment" : "what's up!.. Would def. be there for sure!"},
          {"comment" : "what's up!.. Would def. be there for sure!"},
          {"comment" : "what's up!.. Would def. be there for sure!"},
        ]
      };
    });
  }

  Future<void> postComment(String body, String eventid, List<String> images) async{
    final response = await http.post(
      Uri.parse('$baseUrl/api/comments'),
      // authorisation token from local storage
      headers: {
        HttpHeaders.authorizationHeader : ''
      },
      body: jsonEncode(
        {
          body: body,
          'event_id': eventid,
          'images': []
        }
      )
    );

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw Exception('failed post : ${response.statusCode}');
    }


  }
}