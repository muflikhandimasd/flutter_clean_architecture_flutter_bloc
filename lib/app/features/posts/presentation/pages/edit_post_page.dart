import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/get_post/get_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/update_post/update_post_bloc.dart';

class EditPostPage extends StatefulWidget {
  final Post? post;
  const EditPostPage({super.key, this.post});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    final post = widget.post;
    titleController = TextEditingController(text:post?.title??'' );
    bodyController = TextEditingController(text: post?.body ?? '');
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePostBloc, UpdatePostState>(
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
                  context.read<UpdatePostBloc>().add(UpdatePostEvent.update(
                    id: widget.post?.id ?? 0,
                      title: titleController.text, body: bodyController.text));
                }
              }, child: Text('Simpan'))
            ],)),),
      ),
    );
  }
}
