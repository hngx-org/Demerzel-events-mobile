import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/models/comment.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/http_service/image_upload_service.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  final AuthRepository authRepository;
  final ImageUploadService imageUploadService;
  CommentRepository(
      {required this.authRepository, required this.imageUploadService});

  static final provider = Provider<CommentRepository>((ref) =>
      CommentRepository(
          authRepository: ref.read(AuthRepository.provider),
          imageUploadService: ref.read(ImageUploadService.provider)));

  Future<List<Comment>> getEventComments(String eventId) async {
    final header = await authRepository.getAuthHeader();

    try {
      final http.Response response = await http
          .get(ApiRoutes.eventCommentURI(eventId), headers: header)
          .timeout(const Duration(seconds: 60));

      // await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        return List<Comment>.from(
            data['data']['comments'].map((x) => Comment.fromJson(x)));
      } else {
        throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }

  Future<Comment?> createComment(
      {required String body, required String eventId, File? image}) async {
    final header = await authRepository.getAuthHeader();
    final imageUrls = [];

    if (image != null) {
      final imageUrl = await imageUploadService.uploadImage(image);
      imageUrls.add(imageUrl);
    }

    final jsonBody =
        jsonEncode({"body": body, "event_id": eventId, "images": imageUrls});

    print(jsonBody);

    try {
      final response = await http
          .post(ApiRoutes.commentURI, headers: header, body: jsonBody)
          .timeout(const Duration(seconds: 60));
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        log(data.toString());
        return Comment.fromJson(data['data']['comment']);
      } else {
        return null ;
       // throw response.reasonPhrase ?? response.body;
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      rethrow;
    }
  }
}
