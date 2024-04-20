import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
         state.maybeWhen(
             loading: () {
               showLoading(context);
             },
             error: (message) {
               pop();
               showSnackbar(message);
             },
             success:  () {
               pop();
             },
             orElse: (){

         });
        },
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  if (!EmailValidator.validate(value)) {
                    return "Email tidak valid";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,

                ],
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan email Anda"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  if (value.length < 8) {
                    return "Password minimal 8 karakter";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,

                ],
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Masukkan password Anda"
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginEvent.login(
                      email: emailController.text,
                      password: passwordController.text));
                }
              }, child: Text("Login")),

              SizedBox(height: 20,),
              Text.rich(TextSpan(
                text: "Belum Punya akun? ",
                children: [
                  TextSpan(text: "Daftar sekarang!", style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    pushReplacement(AppPath.register);
                  }
                  )
                ]
              ))
            ],
          ),
        ),
      ),),
    );
  }
}
