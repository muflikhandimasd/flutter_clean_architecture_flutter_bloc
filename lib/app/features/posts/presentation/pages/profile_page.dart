import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/check_login/check_login_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: BlocBuilder<CheckLoginBloc, CheckLoginState>(builder: (context, state) => state.maybeWhen(
        success: (user) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user?.name ?? ''),
              Text(user?.email ?? ''),
            ],);
        },
        orElse: ()=>SizedBox.shrink()),),),);
  }
}
