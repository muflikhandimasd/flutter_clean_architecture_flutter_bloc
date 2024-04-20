import 'package:flutter_clean/app/core/helpers/cekMap.dart';
import 'package:flutter_clean/app/features/auth/domain/entities/message.dart';

class MessageModel extends Message{
const  MessageModel({required super.message});
  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(message: cekMap(json, 'message') ?? '');
  }
}