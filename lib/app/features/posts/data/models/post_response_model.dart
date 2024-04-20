import 'package:flutter_clean/app/core/helpers/cekMap.dart';
import 'package:flutter_clean/app/features/posts/data/models/post_model.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post_response.dart';

import '../../domain/entities/post.dart';

class PostResponseModel extends PostResponse{
 const PostResponseModel({required super.posts});

factory PostResponseModel.fromJson(Map<String, dynamic> json){
  final List<Post> posts=[];

  final dataRaw = cekMap(json, 'data') ?? [];
  if(dataRaw is List && dataRaw.isNotEmpty){
    for(final e in dataRaw){
      posts.add(PostModel.fromJson(e));
    }

  }

  return PostResponseModel(posts: posts);
}

}