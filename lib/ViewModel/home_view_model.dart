import 'package:flutter/cupertino.dart';



class HomeViewModel extends ChangeNotifier {
  // StreamChatClient client = StreamChatClient('');
  // var channel;
  int checkvar = 0;

  changeNum(int val) {
    checkvar = val;
    notifyListeners();
  }

  // assignClient(StreamChatClient value) {
  //   client = value;
  //   notifyListeners();
  // }
  //
  // assignChannel(Channel value) {
  //   channel = value;
  //   notifyListeners();
  // }
}
