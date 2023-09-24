import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

class ImageUploadService {
  final AuthRepository authRepository;
  ImageUploadService({required this.authRepository});

  static final provider = Provider<ImageUploadService>((ref) =>
      ImageUploadService(authRepository: ref.read(AuthRepository.provider)));

  Future<String> uploadImage(File image) async {
    final header = await authRepository.getAuthHeader();

    try {
      var request = http.MultipartRequest('POST', ApiRoutes.imageUploadURI)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          image.path,
        ))
        ..headers.addAll(header);

      var response = await request.send();

      final responseJson = await response.stream.bytesToString();
      Map<String, dynamic> result = jsonDecode(responseJson);

      log(result.toString());

      return  result["data"]["url"];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
