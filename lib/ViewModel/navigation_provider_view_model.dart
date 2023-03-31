import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
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
}
