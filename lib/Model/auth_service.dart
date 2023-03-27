


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
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
        return user;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // void checkNewUser() {
  //   final User? user = _auth.currentUser;
  //   if (user != null) {
  //     final bool isNewUser = user.AdditionalUserInfo?.isNewUser ?? false;
  //     if (isNewUser) {
  //       print('New user signed in!');
  //     } else {
  //       print('Existing user signed in!');
  //     }
  //   }


}