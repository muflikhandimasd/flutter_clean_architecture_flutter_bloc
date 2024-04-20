import 'package:flutter/material.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean/app/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_clean/app/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean/app/features/posts/presentation/pages/create_post_page.dart';
import 'package:flutter_clean/app/features/posts/presentation/pages/edit_post_page.dart';
import 'package:flutter_clean/app/features/posts/presentation/pages/nav_page.dart';

abstract class AppRoute{
  static Route onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case AppPath.login:
        return MaterialPageRoute(builder: (_) => LoginPage(),);

        case AppPath.register:
        return MaterialPageRoute(builder: (_) => RegisterPage(),);

        case AppPath.home:
        return MaterialPageRoute(builder: (_) => NavPage(),);
        case AppPath.createPost:
        return MaterialPageRoute(builder: (_) => CreatePostPage(),);case AppPath.editPost:
          Post? post;
          if(settings.arguments is Post){
            post = settings.arguments as Post;
          }
        return MaterialPageRoute(builder: (_) => EditPostPage(post: post,),);
      default:
        return MaterialPageRoute(builder: (_) => SplashPage(),);
    }
  }
}