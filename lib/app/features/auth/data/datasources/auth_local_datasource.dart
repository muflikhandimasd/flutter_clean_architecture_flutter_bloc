import 'dart:convert';

import 'package:flutter_clean/app/core/exceptions/exceptions.dart';
import 'package:flutter_clean/app/features/auth/data/models/user_model.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDatasource{
  Future<User?> getUser();
  Future<void> cacheUser(User user);
  Future<void> cacheToken(String token);
Future<void> logout();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource{
  final FlutterSecureStorage _storage;

  AuthLocalDatasourceImpl({
    required FlutterSecureStorage storage
}) : _storage = storage;
  @override
  Future<void> cacheToken(String token) async{
   try{
     await _storage.write(key: 'token', value: token);
   }catch(e){
     throw CacheException();
   }
  }

  @override
  Future<void> cacheUser(User user)async{
    try{
      await _storage.write(key: 'user', value: jsonEncode(user.toJson()));
    }catch(e){
      throw CacheException();
    }
  }

  @override
  Future<User?> getUser()async {
  try{
    final user = await _storage.read(key: 'user');
    return user != null? UserModel.fromJson(jsonDecode(user)): null;
  }catch(e){
    throw CacheException();
  }
  }

  @override
  Future<void> logout()async {
   try{
     await _storage.deleteAll();
   } catch(e){
     throw CacheException();
   }
  }

}