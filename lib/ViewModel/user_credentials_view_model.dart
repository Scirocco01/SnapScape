

import 'package:flutter/cupertino.dart';

class UserCredentialsViewModel extends ChangeNotifier{


  List<String> userEntertainment = ['Salud','Music','Mod','Comedy','chill','Science','Political','Movies'];
  var username;


  int pageNum = 0;
  int pageNumber(){
    pageNum += 1;
    notifyListeners();
    return pageNum;
  }



}