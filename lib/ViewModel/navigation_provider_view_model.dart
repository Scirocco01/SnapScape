import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NavigationProvider extends ChangeNotifier {

  User? user = FirebaseAuth.instance.currentUser;



  String profilePhotoUrl = '';
  String userName = '';

  Future<String> getProfilePhotoUrl() async {

    profilePhotoUrl = await _getPhotoFromStorage();
    print('profile url in viewModel is $profilePhotoUrl');

    notifyListeners();
    print('getProfileFunc successfully executed photo uri is $profilePhotoUrl');
    return profilePhotoUrl;
  }

  Future<String> getUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      userName = userDoc.get('userName');
      notifyListeners();
      return userName;
    } catch (e) {
      print('error getting user Name $e');
      userName = 'error 41';
      notifyListeners();
      return userName;
    }
  }

  Future<String> _getPhotoFromStorage() async {
    try {
      Reference photoRef = FirebaseStorage.instance
          .refFromURL(await _getProfilePhotoFromFireStore(user!.uid));
      String downloadUrl = await photoRef.getDownloadURL();
      print('this is the Url $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('error in firebase storage $e');
      return '';
    }
  }

  Future<String> _getProfilePhotoFromFireStore(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      notifyListeners();
      return userDoc.get('photoUrl');
    } catch (e) {
      print('error getting data form cloud fireStore $e');
      return '';
    }
  }






  int _currentIndex = 0;

  String currentTab = "home";

  void changeCurrentTabTo(String newTab) {
    currentTab = newTab;
    print(newTab);
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

    } catch (e) {
      print('Error occurred while signing out: $e');
    }
  }








}
