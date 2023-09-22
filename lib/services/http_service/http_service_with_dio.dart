import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class HttpServiceWithDio {
  static String getBaseURL = 'https://api-s65g.onrender.com/api/';
  static String getGroups = 'groups/user';
  static String createGroup = 'groups';
  static String upload = '/images/upload';

  static Dio _getDioClient() {
    var dio = Dio(BaseOptions(
        baseUrl: getBaseURL,
        connectTimeout: const Duration(seconds: 60000),
        receiveTimeout: const Duration(seconds: 60000),
        responseType: ResponseType.json))
      ..interceptors.add(QueuedInterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers['Authorization'] =
            // TODO update this to follow the format to pass authtoken
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoiYmFkaXJ1c3VsYWltb24yN0BnbWFpbC5jb20iLCJpZCI6IjkyZDYxZjQzLTQ2OTUtNDc1Mi1hM2RhLThhNDk2MjgzYTJlNCIsIm5hbWUiOiJCYWRpcnUgU3VsYWltb24ifSwiZXhwIjoxNjk1NjM3NTc2fQ.bvFUNOU0ziSdrBB_120Ok6CGq49aui9Sy-9eyIHVwNs';
        return handler.next(options);
      }));
    //   ..interceptors
    //       .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //   final dioClient = HttpClient();
    //   dioClient.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) {
    //     return host == '';
    //   });
    //   return dioClient;
    // };
    return dio;
  }

  static Future<AppHttpResponse> post(
      {required String path,
      required Map<String, dynamic> data,
      String key = 'data'}) async {
    try {
      Response response = await _getDioClient().post(path, data: data);
      return AppHttpResponse(false, response.data[key], '');
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<AppHttpResponse> get(
      {required String path,
      required Map<String, dynamic> params,
      String key = 'data'}) async {
    try {
      Response response =
          await _getDioClient().get(path, queryParameters: params);
      return AppHttpResponse(false, response.data[key], '');
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<AppHttpResponse> patch(
      String path, Map<String, dynamic> data) async {
    try {
      Response response = await _getDioClient().patch(path, data: data);
      AppHttpResponse res = AppHttpResponse(false, response.data['data'], '');
      return res;
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static Future<AppHttpResponse> delete(
      String path, Map<String, dynamic> data) async {
    try {
      Response response = await _getDioClient().delete(path, data: data);
      AppHttpResponse res = AppHttpResponse(false, response.data['data'], '');
      return res;
    } on DioException catch (e) {
      return handleError(e);
    }
  }
   static Future<AppHttpResponse> uploadImage(String url, File file) async {
    try {
      Uint8List bytes = await file.readAsBytes();

      var response = await http.put(Uri.parse(url), body: bytes);

      return AppHttpResponse(false, response.statusCode, '');
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  static AppHttpResponse handleError(DioException e) {
    if (e.response != null) {
      dynamic data = e.response?.data;
      if (data != null && data is Map && data.isNotEmpty) {
        Map<String, dynamic> d = Map.from(data);
        return AppHttpResponse(true, e.response?.data, d['message']);
      } else {
        return AppHttpResponse(
          true,
          e.response?.data,
          e.message ?? '',
        );
      }
    } else {
      return AppHttpResponse(true, e.error, e.message ?? '');
    }
  }
}

class AppHttpResponse<T> {
  bool error;
  String message;
  T data;
  AppHttpResponse(this.error, this.data, this.message);
}
