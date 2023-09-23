import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:hng_events_app/models/event_model.dart';

class EventRepository {
  final AuthRepository authRepository;
  EventRepository({required this.authRepository});

  static final provider = Provider<EventRepository>((ref) =>
      EventRepository(authRepository: ref.read(AuthRepository.provider)));

  Future<GetListEventModel> getAllEvent() async {
    final header = await authRepository.getAuthHeader();

    try {
      final http.Response response = await http
          .get(ApiRoutes.eventURI, headers: header)
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return GetListEventModel.fromMap(data);
      } else {
        throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future<bool> createEvent(Map<String, dynamic> body) async {
    final header = await authRepository.getAuthHeader();

    log(body.toString());

    try {
      final http.Response response = await http
          .post(ApiRoutes.eventURI, headers: header, body: json.encode(body))
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
      } else {
        throw response.reasonPhrase ?? response.body;
      }

      return true;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future<GetListEventModel> getEventsByDate(String date) async {
    final String url = "https://api-s65g.onrender.com/api/events?date=$date";
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
        return GetListEventModel.fromMap(data);
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
