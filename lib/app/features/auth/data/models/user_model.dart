import 'package:flutter_clean/app/core/helpers/cekMap.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';

class UserModel extends User{
  UserModel({required super.id, required super.name, required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json, {
    String token = ''
  }){
    return UserModel(id: cekMap(json, 'id') ?? 0, name: cekMap(json, 'name') ?? '', email: cekMap(json, 'email')??'', token: token);
  }

  @override
  Map<String, dynamic> toJson() {
   return {
     'id':id,
     'name':name,
     'email':email,
   };
  }

}