


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Model/auth_service.dart';

class AuthViewModel extends ChangeNotifier{
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;


  Future<void> signInWithGoogle() async {
    final User? user = await _authService.signInWithGoogle();
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

}