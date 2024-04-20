import 'package:flutter_clean/app/core/helpers/cekInternet.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo{
  @override
  Future<bool> get isConnected => cekInternet();

}