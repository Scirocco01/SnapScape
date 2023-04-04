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