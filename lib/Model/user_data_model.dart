import 'dart:io';

class UserDataModel{
  String name;
  String userName;
  File photo;
  String bio;

  UserDataModel({required this.name,
    required this.userName,
    required this.photo,
    required this.bio
  });

}

class MessageReceiverDataModel{
  String name;
  String userName;
  String profilePhotoUrl;

  MessageReceiverDataModel({required this.name,required this.userName,required this.profilePhotoUrl});
}