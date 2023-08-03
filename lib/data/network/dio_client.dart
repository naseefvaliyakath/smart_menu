import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/url.dart';

class DioClient {
  final Dio _dio;

  DioClient({String? token})
      : _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {"Authorization": token != null ? "Bearer $token" : ""})) {
    initializeInterceptors();
  }

  Future<Response> getRequest(String url) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.get(url);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  //? if forceOnline is true then even in offline app it will fetch data from server
  //? in sum case it needed eg:menuBook
  Future<Response> getRequestWithBody(String url, body) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  //? delete with id
  Future<Response> delete(String url, {String? id}) async {
    Response response;
    try {
      response = await _dio.delete(id != null ? '$url/$id' : url);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}
    return response;
  }

  Future<Response> updateData(String url, dynamic body) async {
    Response response;
    try {
      response = await _dio.put(url, data: json.encode(body));
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}
    return response;
  }

  //?insert with body
  Future<Response> insertWithBody(String url, body) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.post(url, data: body);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  Future<Response> postMultipart(String url, FormData formData) async {
    Response response;
    try {
      response = await _dio.post(url, data: formData);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }


  Future<Response> putMultipart(String url, FormData formData) async {
    Response response;
    try {
      response = await _dio.put(url, data: formData);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }


  Future<String> downloadFile(String url, String filename) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      await _dio.download(url, "${dir.path}/$filename");
      return "${dir.path}/$filename";
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) async {
      if (kDebugMode) {
        // print("${request.method} | ${request.path}");
      }
      return handler.next(request); //continue
    }, onResponse: (response, handler) {
      //? Do something with response data
      if (kDebugMode) {
        // print("response from intercept ${response.statusCode} ${response.statusMessage} ${response.data}");
      }
      return handler.next(response); // continue
    }, onError: (DioException e, handler) {
      //? Do something with response error
      if (kDebugMode) {
        // print('deo error${e.message}');
      }
      return handler.next(e);
    }));
  }
}
