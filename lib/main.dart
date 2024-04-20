import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/core/routes/app_route.dart';
import 'package:flutter_clean/app/service_locator.dart';

Future<void> main() async{
  await ServiceLocator.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: ServiceLocator.providers, child: MainAppView());
  }
}


class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Clean",
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldKey,
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: AppPath.splash,
    );
  }
}
