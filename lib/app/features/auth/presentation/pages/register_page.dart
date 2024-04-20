import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/auth/presentation/blocs/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocListener<RegisterBloc, RegisterState>(
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
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,

                ],
                decoration: InputDecoration(
                    labelText: "Nama",
                    hintText: "Masukkan nama Anda"
                ),
              ),
              SizedBox(height: 10,),   TextFormField(
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
                  context.read<RegisterBloc>().add(RegisterEvent.register(
                      email: emailController.text,
                      name: nameController.text,
                      password: passwordController.text));
                }
              }, child: Text("Register")),

              SizedBox(height: 20,),
              Text.rich(TextSpan(
                text: "Sudah Punya akun? ",
                children: [
                  TextSpan(text: "Masuk sekarang!", style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    pushReplacement(AppPath.login);

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
