import 'package:dio/dio.dart';
import 'package:flutter_clean/app/core/failure/failure.dart';
import 'package:flutter_clean/app/core/helpers/cekMap.dart';

String getErrorMessage(DioException e){
  var msg = messageInternal;
  switch(e.type){
    case DioExceptionType.connectionError:
      msg="Periksa Koneksi Internet Anda";
      break;
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      msg="Permintaan Kehabisan Waktu, Silakan Coba kembali";
      break;
    default:
  }

  final responseData = e.response?.data;
  if(responseData is Map<String, dynamic>){
    msg = cekMap(responseData, 'message')?? messageInternal;
  }
  return msg;
}