import 'package:flutter_clean/app/features/auth/domain/entities/user.dart';

abstract class Post{
  final int id;
  final String title,body;
  final DateTime createdAt,updatedAt;
  final User user;

  const Post({
   required this.id,
   required this.title, 
   required this.body,
   required this.createdAt,
   required this.updatedAt,
   required this.user,
});
}