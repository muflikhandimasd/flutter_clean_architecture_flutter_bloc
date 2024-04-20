import 'package:flutter/material.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void showSnackbar(String message){
  scaffoldKey.currentState?..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(message)));
}
void showLoading(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20.0),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}