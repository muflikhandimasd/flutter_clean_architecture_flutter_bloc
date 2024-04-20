import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/create_post/create_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/get_post/get_post_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    bodyController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            showLoading(context);
          },
          error: (message) {
            pop();
            showSnackbar(message);
          },
          success: (message) {
            pop();
            showSnackbar(message);
            context.read<GetPostBloc>().add(GetPostEvent.started());
            pushAndRemove(AppPath.home);
          },
          orElse: () {

        },);
      },
      child: Scaffold(
        body: Center(child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Judul tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Judul",
                    hintText: "Masukkan Judul"
                ),
              ),
              SizedBox(height: 20,), TextFormField(
                controller: bodyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Isi tidak boleh kosong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Isi",
                    hintText: "Masukkan Isi"
                ),
              ),
              SizedBox(height: 20,),

              ElevatedButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<CreatePostBloc>().add(CreatePostEvent.create(
                      title: titleController.text, body: bodyController.text));
                }
              }, child: Text('Simpan'))
            ],)),),
      ),
    );
  }
}
