import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/check_login/check_login_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckLoginBloc, CheckLoginState>(
      listener: (context, state) {

        state.maybeWhen(

          success:(result) {
            if(result != null){
              pushAndRemove(AppPath.home);
            }else{
              pushAndRemove(AppPath.login);
            }
          },
          error: (_) {
            pushAndRemove(AppPath.login);
          },
          orElse: () {

        },);
      },
      child: Scaffold(
        body: Center(
          child: Icon(Icons.api_rounded),
        ),
      ),
    );
  }
}
