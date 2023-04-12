

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  String senderId;
  String receiverId;
  String text;
  Timestamp timeStamp;
  MessageModel({required this.senderId,required this.receiverId,required this.text,required this.timeStamp});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      text: json['message'],
      timeStamp: json['timestamp'],
    );
  }

}