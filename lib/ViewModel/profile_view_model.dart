


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier{
  User? user = FirebaseAuth.instance.currentUser;





}