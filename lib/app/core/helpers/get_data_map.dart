import 'package:dio/dio.dart';
import 'package:flutter_clean/app/core/helpers/cekMap.dart';

Map<String, dynamic> getDataMap(Response response){
  return cekMap(response.data, 'data') ?? <String, dynamic>{};
}