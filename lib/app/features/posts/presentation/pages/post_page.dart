import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean/app/core/helpers/navigator_helper.dart';
import 'package:flutter_clean/app/core/helpers/show_snackbar.dart';
import 'package:flutter_clean/app/core/routes/app_path.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/delete_post/delete_post_bloc.dart';
import 'package:flutter_clean/app/features/posts/presentation/blocs/get_post/get_post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  void initState() {
    context.read<GetPostBloc>().add(GetPostEvent.started());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeletePostBloc, DeletePostState>(
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
     },
     orElse: () {

   },);
  },
  child: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        push(AppPath.createPost);
      },
        backgroundColor: Colors.blue,
      child: Icon(Icons.add),
      ),
      body: BlocBuilder<GetPostBloc, GetPostState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Center(child: CircularProgressIndicator(),),
            error: (message) {
              return Center(child: Text(message),);
            },
            loaded: (posts) => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: posts.length, itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                return ListTile(title: Text(post.title),

                subtitle: Text(post.body),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      switch(value){
                        case 0:
                          push(AppPath.editPost, arguments: post);
                          break; 
                          case 1:
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Yakin Hapus Post Ini"),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    pop();
                                  }, child: Text('Tidak')),ElevatedButton(onPressed: (){
                                    context.read<DeletePostBloc>().add(DeletePostEvent.delete(id: post.id));
                                    pop();
                                  }, child: Text('Ya')),
                                ],
                              );
                            },);
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) { return[
                    PopupMenuItem(
                        value: 0,
                        child: Text("Edit")),
                    PopupMenuItem(
                        value: 1,
                        child: Text("Hapus"))
                  ]; },
                    
                  ),
                );
            },),
            orElse: () => SizedBox.shrink(),);
        },
      ),
    ),
);
  }
}
