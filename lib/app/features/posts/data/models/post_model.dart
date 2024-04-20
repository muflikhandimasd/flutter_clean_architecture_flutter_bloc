import 'package:flutter_clean/app/core/helpers/cekMap.dart';
import 'package:flutter_clean/app/features/auth/data/models/user_model.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post.dart';

class PostModel extends Post{
 const PostModel({required super.id, required super.title, required super.body, required super.createdAt, required super.updatedAt, required super.user});


 factory PostModel.fromJson(Map<String,dynamic> json){
   return PostModel(id: cekMap(json, 'id')??0, title: cekMap(json,'title')??'', body: cekMap(json,'body')?? '', createdAt: DateTime.parse(cekMap(json, 'created_at')?? DateTime.now().toIso8601String()), updatedAt: DateTime.parse(cekMap(json, 'updated_at')?? DateTime.now().toIso8601String()), user: UserModel.fromJson(cekMap(json, 'user')??<String, dynamic>{}));
 }

}