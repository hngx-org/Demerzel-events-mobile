import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/api_service.dart';
import 'package:hng_events_app/services/http_service/image_upload_service.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:hng_events_app/models/event_model.dart';

class EventRepository {
  final AuthRepository authRepository;
  final ImageUploadService imageUploadService;
  final ApiService apiService;
  EventRepository(
      {required this.authRepository,
      required this.imageUploadService,
      required this.apiService});

  static final provider = Provider<EventRepository>((ref) => EventRepository(
      authRepository: ref.read(AuthRepository.provider),
      apiService: ref.read(ApiServiceImpl.provider),
      imageUploadService: ref.read(ImageUploadService.provider)));

  Future<bool> subscribeToEvent(String eventId) async {
    final header = await authRepository.getAuthHeader();

    await apiService.post(
        url: ApiRoutes.subscribeToEventURI(eventId), body: {}, headers: header);

    return true;
  }

  Future<List<Event>> getAllUserEvents() async {
    final header = await authRepository.getAuthHeader();

    final result =
        await apiService.get(url: ApiRoutes.userEventURI, headers: header);

    return result['data']['events'] == null
        ? []
        : List<Event>.from(
            result['data']['events'].map((x) => Event.fromMap(x)));
  }

  Future<GetListEventModel> getAllEvent() async {
    final header = await authRepository.getAuthHeader();

    try {
      final http.Response response = await http
          .get(ApiRoutes.eventURI, headers: header)
          .timeout(const Duration(seconds: 60));

      final Map<String, dynamic> data = json.decode(response.body);

      log(data['data']['events'].length.toString());

      
      final result = GetListEventModel.fromMap(data);


      return result;

    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

    Future<GetListEventModel> getUpcomingEvent() async {
    final header = await authRepository.getAuthHeader();

    try {
      final http.Response response = await http
          .get(ApiRoutes.upcomingEventURI, headers: header)
          .timeout(const Duration(seconds: 60));

      final Map<String, dynamic> data = json.decode(response.body);

      log(data['data']['events'].length.toString());

      
      final result = GetListEventModel.fromMap(data);


      return result;

    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future<GroupEventListModel?> getAllGroupEvent(String groupId) async {
    final header = await authRepository.getAuthHeader();
print(header);
    try {
      final http.Response response = await http
          .get(ApiRoutes.groupEventURI(groupId), headers: header)
          .timeout(const Duration(seconds: 60));
print("this is ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
       // log(data.toString());

        return 
        data['data'] != null
            ? GroupEventListModel.fromMap(data)
            : null;
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

    final imageUrl = await imageUploadService.uploadImage(body['image']);

    body["thumbnail"] = imageUrl;
    body.remove("image");

   // log(body.toString());

    final result =
        apiService.post(url: ApiRoutes.eventURI, body: body, headers: header);
   // log(result.toString());

    return true;
  }

  Future<GetListEventModel> getEventsByDate(DateTime date) async {
    final header = await authRepository.getAuthHeader();

    final formatedDate = DateFormatter.formatDate(date);

    final queryParameters = {
      'start_date': formatedDate,
    };

    final uri = Uri.https(ApiRoutes.host, '/api/events', queryParameters);

    try {
      final http.Response response = await http
          .get(
           uri,
            headers: header,
          )
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
       // log(data.toString());
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
