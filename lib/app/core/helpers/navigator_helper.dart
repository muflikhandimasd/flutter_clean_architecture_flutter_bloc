import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(String path, {Object? arguments}){
  navigatorKey.currentState?.pushNamed(path, arguments: arguments);
}

void pushAndRemove(String path, {Object? arguments}){
  navigatorKey.currentState?.pushNamedAndRemoveUntil(path,(_)=> false ,arguments: arguments);
}

void pushReplacement(String path, {Object? arguments}){
  navigatorKey.currentState?.pushReplacementNamed(path,arguments: arguments);
}

void pop(){
  navigatorKey.currentState?.pop();
}