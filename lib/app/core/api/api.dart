import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  Api({required Dio dio, required FlutterSecureStorage storage})
      : _dio = dio,
        _storage = storage{
    const timeOut = Duration(minutes: 1);
    _dio.options = BaseOptions(
      baseUrl: 'http://<YOUR_IP>:9221/api/v1',
      sendTimeout: timeOut,
      connectTimeout: timeOut,
      receiveTimeout: timeOut
    );
   if(kDebugMode){
     _dio.interceptors.add(LogInterceptor(
       requestBody: true,
       responseBody: true
     ));
   }

   _dio.interceptors.add(InterceptorsWrapper(
     onRequest: (options, handler) async{
       options.headers['Content-Type'] ='application/json';
       options.headers['Accept'] ='application/json';

       final token = await _storage.read(key: 'token');
       if(token != null){
         options.headers['Authorization'] ='Bearer $token';
       }
       return handler.next(options);

     },
     onResponse: (response, handler) {


       return handler.next(response);
     },

   ));
  }

  Future<Response> get( String path, {   Map<String, dynamic>? queryParameters,      void Function(int, int)? onReceiveProgress, }){
    return _dio.get(path, queryParameters: queryParameters, onReceiveProgress: onReceiveProgress);
  }

  Future<Response> post(  String path, {   Object? data,   Map<String, dynamic>? queryParameters,    void Function(int, int)? onSendProgress,   void Function(int, int)? onReceiveProgress, }){
    return _dio.post(path, queryParameters: queryParameters,data: data,onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
  }Future<Response> put(  String path, {   Object? data,   Map<String, dynamic>? queryParameters,    void Function(int, int)? onSendProgress,   void Function(int, int)? onReceiveProgress, }){
    return _dio.put(path, queryParameters: queryParameters,data: data,onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
  }

  Future<Response> delete( String path, {   Map<String, dynamic>? queryParameters,       }){
    return _dio.delete(path, queryParameters: queryParameters,);
  }
}
