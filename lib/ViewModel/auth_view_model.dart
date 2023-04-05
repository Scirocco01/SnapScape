



import 'package:ehisaab_2/View/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../View/UserCredentials/user_credentials.dart';
import '../View/bottom_navigation.dart';


class AuthViewModel extends ChangeNotifier{

  User? _user;

  User? get user => _user;


  Future<User?> signInWithGo() async {
     User? user = await _signInWithGoogle();
    if (user != null) {
      _user = user;
      notifyListeners();
      return user;
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
        print('this is the user ${user}');
        return user;
      }
      return null;
    } catch (e) {
      print('catch error $e');
      return null;
    }
  }








}