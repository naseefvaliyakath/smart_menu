import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:path_provider/path_provider.dart';
import 'package:smart_menu/constants/app_constant_names.dart';
import '../../constants/url.dart';
import 'handle_error.dart';


class DioClient extends GetxController {
  Dio _dio = Dio();

  //? secure storage for saving token
  FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  String token = '';


  @override
  Future<void> onInit() async {
    token = await storage.read(key: KEY_TOKEN) ?? '';
    log('Token $token');
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {"Authorization": "Bearer $token"},
    ));
    initializeInterceptors();
    super.onInit();
  }

  Future<Response> getRequest(String url, {bool showSnack = true}) async {
    try {
      if(url.contains('shop/getShopByPhone/')){
        _dio.options.headers['Authorization'] = 'Bearer $STATIC_TOKEN';
      }
      Response response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e,
          isDioError: true, page: 'dio_client', method: 'getRequest', showSnack: showSnack);
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, page: 'dio_client', method: 'getRequest');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  //? if forceOnline is true then even in offline app it will fetch data from server
  //? in sum case it needed eg:menuBook
  Future<Response> getRequestWithBody(String url, body, {bool showSnack = true}) async {
    try {
      Response response = await _dio.get(url, queryParameters: body);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e,
          isDioError: true, page: 'dio_client', method: 'getRequestWithBody', showSnack: showSnack);
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'getRequestWithBody');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  //? delete with id
  Future<Response> delete(String url, {String? id}) async {
    try {
      Response response = await _dio.delete(id != null ? '$url/$id' : url);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: true, page: 'dio_client', method: 'delete');
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'delete');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  Future<Response> updateData(String url, dynamic body) async {
    try {
      Response response = await _dio.put(url, data: json.encode(body));
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: true, page: 'dio_client', method: 'updateData');
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'updateData');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  //?insert with body
  Future<Response> insertWithBody(String url, body) async {
    // TODO: implement getRequest
    try {
      if(url == 'shop/verifyOTPAndCreateShop' || url.contains('shop/initiateCreateShop')){
        _dio.options.headers['Authorization'] = 'Bearer $STATIC_TOKEN';
      }
      Response response = await _dio.post(url, data: body);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: true, page: 'dio_client', method: 'insertWithBody');
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'insertWithBody');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  Future<Response> postMultipart(String url, FormData formData) async {
    try {
      Response response = await _dio.post(url, data: formData);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: true, page: 'dio_client', method: 'postMultipart');
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'postMultipart');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  Future<Response> putMultipart(String url, FormData formData) async {
    try {
      Response response = await _dio.put(url, data: formData);
      return response;
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: true, page: 'dio_client', method: 'putMultipart');
      return Response(requestOptions: RequestOptions(), data: null);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'putMultipart');
      return Response(requestOptions: RequestOptions(), data: null);
    }
  }

  Future<String> downloadFile(String url, String filename) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      await _dio.download(url, "${dir.path}/$filename");
      return "${dir.path}/$filename";
    } on DioException catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'downloadFile');
      return '';
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'dio_client', method: 'downloadFile');
      return '';
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

  updatingToken(tokenFromLogin) {
    token = tokenFromLogin;
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {"Authorization": "Bearer $token"}));
    update();
  }
}
