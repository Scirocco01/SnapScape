import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';



class HomeViewModel extends ChangeNotifier {

  String userId  = '';
  String profilePhotoUrl = '';
  String userName = '';



  User? user = FirebaseAuth.instance.currentUser;

  /// for User Data like name and profile Photo
  
  Future<String> _getProfilePhotoFromFireStore(String userId) async {
    try{
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      userName = userDoc.get('userName');
      notifyListeners();
      return userDoc.get('photoUrl');
    }
    catch(e){
      print('error getting data form cloud fireStore $e');
      return '';
    }
  }


  Future<String> _getPhotoFromStorage() async {
    try{
      Reference photoRef = FirebaseStorage.instance.refFromURL(await _getProfilePhotoFromFireStore(user!.uid));
      String downloadUrl = await photoRef.getDownloadURL();
      return downloadUrl;
    }
    catch(e){
    print('error in firebase storage $e');
    return '';
    }
  }


    getProfilePhotoUrl() async {
    profilePhotoUrl = await _getPhotoFromStorage();
    notifyListeners();
    print('getProfileFunc successfully executed photo uri is $profilePhotoUrl');
  }





}
