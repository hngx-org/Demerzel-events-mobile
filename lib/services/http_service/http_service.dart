import 'dart:convert';
import 'dart:async';
import 'package:hng_events_app/services/http_service/response_handler.dart';
import 'package:http/http.dart' as http;

//HttpService - contains CRUD operations that interact with backend
class HttpService {
  //insert baseurl from backend dev
  final String baseUrl = '';

  //handle get request from backend
  Future<dynamic> get(String path) async {
    final String url = baseUrl + path;
    final response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
    return handleResponse(response);
  }

  //handle post request backend
  Future<dynamic> post(String path, Map<dynamic, dynamic> body) async {
    final String url = baseUrl + path;

    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .post(Uri.parse(url), body: json.encode(body))
        .timeout(const Duration(seconds: 60));
    return handleResponse(response);
  }

  //handle put request from the backend
  Future<dynamic> put(String path, Map<dynamic, dynamic> body) async {
    final String url = baseUrl + path;

    final response = await http
        .put(Uri.parse(url), body: json.encode(body))
        .timeout(const Duration(seconds: 60));
    return handleResponse(response);
  }

  //handle update event logic from the backend
  Future<dynamic> update(String path, Map<dynamic, dynamic> body) async {
    final String url = baseUrl + path;

    final response = await http
        .patch(Uri.parse(url), body: json.encode(body))
        .timeout(const Duration(seconds: 60));
    return handleResponse(response);
  }

  Future<dynamic> delete(String path, int id) async {
    final String url = baseUrl + path;

    final response = await http.patch(Uri.parse(url));
  }

  //handles fetching of comment from backend TODO: how to pass body to get request in http package
  viewEventbyId() {}

  //TODO: rsvp request
  rsvpEvent() {}
}
