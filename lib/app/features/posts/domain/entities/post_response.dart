import 'package:flutter_clean/app/features/posts/domain/entities/post.dart';

abstract class PostResponse{
  final List<Post> posts;

  const PostResponse({
    required this.posts
});
}