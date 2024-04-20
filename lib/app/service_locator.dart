
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean/app/core/api/api.dart';
import 'package:flutter_clean/app/core/network_info/network_info.dart';
import 'package:flutter_clean/app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_clean/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_clean/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/check_login/check_login_bloc.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/logout/logout_bloc.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_clean/app/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:flutter_clean/app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:flutter_clean/app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/create_post_usecase.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_clean/app/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/create_post/create_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/delete_post/delete_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/get_post/get_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/update_post/update_post_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final sl = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> init() async {
    Bloc.observer = _AppBlocObserver();
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
    sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true)
    ));
    sl.registerLazySingleton<Api>(() => Api(dio: Dio(), storage: sl()));
    sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(api: sl()));
    sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl(storage: sl()));

    sl.registerLazySingleton<AuthRepository>(()=> AuthRepositoryImpl(remoteDatasource: sl(), localDatasource: sl(), networkInfo: sl()));
    sl.registerLazySingleton<LoginUsecase>(()=> LoginUsecase(repository: sl()));
    sl.registerLazySingleton<RegisterUsecase>(()=> RegisterUsecase(repository: sl()));
    sl.registerLazySingleton<LogoutUsecase>(()=> LogoutUsecase(repository: sl()));
    sl.registerLazySingleton<CheckLoginUsecase>(()=> CheckLoginUsecase(repository: sl()));
    sl.registerFactory<LoginBloc>(()=> LoginBloc(sl()));
    sl.registerFactory<RegisterBloc>(()=> RegisterBloc(sl()));
    sl.registerFactory<LogoutBloc>(()=> LogoutBloc(sl()));
    sl.registerFactory<CheckLoginBloc>(()=> CheckLoginBloc(sl()));

    sl.registerLazySingleton<PostRemoteDatasource>(() => PostRemoteDatasourceImpl(api: sl()));
    sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()));
    sl.registerLazySingleton<GetPostsUsecase>(()=> GetPostsUsecase(repository: sl()));
    sl.registerLazySingleton<CreatePostUsecase>(()=> CreatePostUsecase(repository: sl()));
    sl.registerLazySingleton<UpdatePostUsecase>(()=> UpdatePostUsecase(repository: sl()));
    sl.registerLazySingleton<DeletePostUsecase>(()=> DeletePostUsecase(repository: sl()));
    sl.registerFactory<GetPostBloc>(()=> GetPostBloc(sl()));
    sl.registerFactory<CreatePostBloc>(()=> CreatePostBloc(sl()));
    sl.registerFactory<UpdatePostBloc>(()=> UpdatePostBloc(sl()));
    sl.registerFactory<DeletePostBloc>(()=> DeletePostBloc(sl()));
  }

  static List<BlocProvider> get providers => [
    BlocProvider<LoginBloc>(create:(_)=>sl<LoginBloc>() ),
    BlocProvider<RegisterBloc>(create:(_)=>sl<RegisterBloc>() ),
    BlocProvider<LogoutBloc>(create:(_)=>sl<LogoutBloc>() ),
    BlocProvider<CheckLoginBloc>(create:(_)=>sl<CheckLoginBloc>() ),
    // POSTS
    BlocProvider<GetPostBloc>(create:(_)=>sl<GetPostBloc>() ),
    BlocProvider<CreatePostBloc>(create:(_)=>sl<CreatePostBloc>() ),
    BlocProvider<UpdatePostBloc>(create:(_)=>sl<UpdatePostBloc>() ),
    BlocProvider<DeletePostBloc>(create:(_)=>sl<DeletePostBloc>() ),
  ];
}

class _AppBlocObserver extends BlocObserver{
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("${bloc.runtimeType} - ${change.currentState} : ${change.nextState}");
    super.onChange(bloc, change);
  }
}