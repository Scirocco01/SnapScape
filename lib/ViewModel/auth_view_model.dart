



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';




class AuthViewModel extends ChangeNotifier{

  User? _user;

  User? get user => _user;


  Future<User?> signInWithGo() async {
     User? user = await _signInWithGoogle();
    if (user != null) {
      _user = user;
      notifyListeners();
      if(await _checkIfUserExistsInFireStore(_user?.uid)) {
        return user;
      }
      else{
        print('user doesNot Exist in fireStore');
        return null;
      }


    }
    else{
      return null;
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        notifyListeners();
        print('this is the user ${user}');
        return user;
      }
      return null;
    } catch (e) {
      print('catch error $e');
      return null;
    }
  }


  Future<bool> _checkIfUserExistsInFireStore(String? userId) async {
    final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if(userSnapshot.exists){
      print('userDoesExist in FireStore');
      return true;

    }
    else{
      return false;
    }
  }








}