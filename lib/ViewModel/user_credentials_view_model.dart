

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


class UserCredentialsViewModel extends ChangeNotifier{

  int pageNum = 0;



   pageNumber(){
    pageNum += 1;
    notifyListeners();

  }

  String name = '';
   String userName = '';
   File photo= File('');
   String bio = '';


  UserDataModel userData = UserDataModel(name: '', userName: '', photo: File(''), bio:'');


  selectName(String alphaName){
    userData.name =  alphaName;
    print('this is the name ${userData.name}');
    notifyListeners();
  }

  selectUserName(String betaName){
    userData.userName = betaName;
    print('this is the name ${userData.name}');
    notifyListeners();
  }

  selectPhoto(File pickedPhoto){
    userData.photo = pickedPhoto;
    print('photo    Photo photo ${userData.photo}');
    notifyListeners();
  }

  selectBio(String personalData){
    userData.bio = personalData;
    print('this is the name ${userData.bio}');
    notifyListeners();
  }






  callSaveData(User? user)async{
    if(user?.uid != null) {
      final String? iD = user?.uid.toString();
      await _saveUserData(userData, iD!);
    }
  }


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveUserData(UserDataModel userData, String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set({'name': userData.name,
        'userName': userData.userName,
        'photoUrl': await _uploadPhoto(userData.photo),
        'bio': userData.bio
      });
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<String> _uploadPhoto(File photo) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('user_photos/${DateTime.now().millisecondsSinceEpoch}}');
      final UploadTask uploadTask = storageReference.putFile(photo);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading photo: $e');
      return '';
    }
  }











}