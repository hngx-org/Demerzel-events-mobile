import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/api_constant.dart';
import 'package:logger/logger.dart';

abstract class ApiService {
  //? For making get request to the endpoint
  Future<dynamic> get({
    required Uri url,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic>? headers,
  });

  //? For making post request to the endpoint
  Future<dynamic> post({
    required Uri url,
    required Map<String, dynamic> body,
    Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
  });

  //? For making patch request to the endpoint
  Future<dynamic> patch({
    required Uri url,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  });

  //? For making delete request to the endpoint
  Future<dynamic> delete({
    required Uri url,
    Map<String, dynamic>? queryParameters,
    Map<String, String> headers,
  });

  //? For making put request to the endpoint
  Future put(
      {required Uri url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});
}

class ApiServiceImpl implements ApiService {
  final _log = Logger();
  final Dio _dio;

  static final provider =
      Provider<ApiService>(((ref) => ApiServiceImpl(Dio())));

  ApiServiceImpl(this._dio) {
    _dio.options.baseUrl = ApiRoutes.baseUri.toString();
    _dio.options.validateStatus = (status) => status! < 500;
    _log.i('Api constructed and DIO setup register');
  }

  @override
  Future get(
      {required Uri url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    _log.i(
        'Making Get Request to $url with the following data \n$queryParameters');
    try {
      final response = await _dio.get(
        url.toString(),
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        _log.e('Error from $url', error: response.data);
        throw Exception(response.data);
      }
      
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (error) {
      _log.e('Error from $url', error: error);
      return error;
    }
  }

  @override
  Future post(
      {required Uri url,
      required Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    _log.i('Making Post Request to $url with the following data \n$body');
    try {
      final response = await _dio.post(url.toString(),
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameters);

      if (response.statusCode != 200 && response.statusCode != 201) {
        _log.e('Error from $url', error: response.data);
        throw Exception(response.data);
      }
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (error) {
      _log.e('Error from $url', error: error);
      return error;
    }
  }

  @override
  Future put(
      {required Uri url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    _log.i('Making Put Request to $url with the following data \n$body');
    try {
      final response = await _dio.put(url.toString(),
          data: body, options: Options(headers: headers));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _log.e('Error from $url', error: response.data);
        throw Exception(response.data);
      }
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (error) {
      _log.e('Error from $url', error: error);
      return error;
    }
  }

  @override
  Future delete(
      {required Uri url,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    _log.i('Making Delete Request to $url.');
    try {
      final response = await _dio.delete(url.toString(),
          queryParameters: queryParameters, options: Options(headers: headers));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _log.e('Error from $url', error: response.data);
        throw Exception(response.data);
      }
      _log.i('Response from $url \n${response.data}');

      return response.data;
    } on DioException catch (error) {
      _log.e('Error from $url', error: error);
      return error;
    }
  }

  @override
  Future patch(
      {required Uri url,
      required Map<String, dynamic> body,
      required Map<String, String> headers}) {
    throw UnimplementedError();
  }
}
