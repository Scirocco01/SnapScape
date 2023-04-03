

import 'package:flutter/cupertino.dart';


class UserCredentialsViewModel extends ChangeNotifier{

  int pageNum = 0;
  var username;
  List<String> userEntertainment = ['Sase','Music','Mod','Comedy','chill','Science','Political','Movies'];


   pageNumber(){
    pageNum += 1;
    notifyListeners();

  }






}