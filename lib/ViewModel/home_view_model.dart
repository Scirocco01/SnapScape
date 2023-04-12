import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model_for_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../Model/messages_model.dart';

class HomeViewModel extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;



  String profilePhotoUrl = '';
  String userName = '';

  //get userName for Home Page
  _userNameForHomePage() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      userName = userDoc.get('userName');
      notifyListeners();
    } catch (e) {
      print('error getting user Name $e');
      userName = 'error 41';
      notifyListeners();
    }
  }

  /// for User Data like name and profile Photo

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

  Future<String> _getPhotoFromStorage() async {
    try {
      Reference photoRef = FirebaseStorage.instance
          .refFromURL(await _getProfilePhotoFromFireStore(user!.uid));
      String downloadUrl = await photoRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('error in firebase storage $e');
      return '';
    }
  }

  getProfilePhotoUrl() async {
    _userNameForHomePage();
    profilePhotoUrl = await _getPhotoFromStorage();
    notifyListeners();
    print('getProfileFunc successfully executed photo uri is $profilePhotoUrl');
  }

  /// for message system

  //creating a collection for messages in firebase fireStore
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');

  // implementing a function to send the message
  Future<void> sendMessage(String senderId, receiverID, String textMessage) {
    return messageCollection.add({
      'senderId': senderId,
      'receiverId': receiverID,
      'messageText': textMessage,
      'timeStamp': FieldValue.serverTimestamp()
    });
  }

  Stream<QuerySnapshot> getMessagesStream(String senderId, String receiverId) {
    return messageCollection
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // a list of user id's the user searches with user names
  List<String> userIdListForMessageSearch = [];

  // list for userMessageModel to show suggested users when user starts searching for new messages
  List<UserMessageModel> userListForMessage = [];

  // Search user by their user name and saves to (userIdListForMessageSearch) List
  searchUserName(String userName) async {
    emptyUserListForMessage();
    String matchMakingUsers = '';
    QuerySnapshot querySnapshot;

    do {
      print('this is the UserName = $userName');
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userName', isGreaterThanOrEqualTo: userName)
          .where('userName', isLessThan: '${userName}z')
          .get();

      querySnapshot.docs.forEach((doc) {
        matchMakingUsers = doc.id;
      });
      if (matchMakingUsers.isEmpty) {
        userName = userName.substring(0, userName.length - 1);
      }
    } while (matchMakingUsers.isEmpty && userName.isNotEmpty);

    matchMakingUsers;
    print('this is the matchmaking list $matchMakingUsers');
    await _getUserById(matchMakingUsers);
    notifyListeners();
  }

  // function which searches and gives user according to UserID
  _getUserById(String userIDList) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userIDList)
        .get();
    print(
        'the bool value of _checkIfListContainsUser ${_checkIfListContainsUser(userDoc.get('userName'))}');
    if (userDoc.exists) {
      if (await _checkIfListContainsUser(await userDoc.get('userName')) !=
          true) {
        userListForMessage.add(UserMessageModel(
          searchedUserId: userDoc.id,
          profilePic: await _getProfilePhotoFromFireStore(userIDList),
          fullName: await userDoc.get('name'),
          userName: await userDoc.get('userName'),
        ));
      }
      print(
          'user found and this is the user $userListForMessage list length is ${userListForMessage.length}');
      print('the user id for userName ${userListForMessage[0].searchedUserId}');

      //to sort the list for best matchmaking
      userListForMessage.sort((a, b) {
        if (a.userName.startsWith(userName) &&
            !b.userName.startsWith(userName)) {
          return -1;
        } else if (!a.userName.startsWith(userName) &&
            b.userName.startsWith(userName)) {
          return 1;
        } else {
          return a.userName.compareTo(b.userName);
        }
      });
      notifyListeners();
    } else {
      print('User not found');
    }
  }

  Future<bool> _checkIfListContainsUser(String userName) async {
    return userListForMessage.any((user) => user.userName == userName);
  }

  emptyUserListForMessage() {
    userListForMessage = [];
    notifyListeners();
    print('emptied the List');
  }

  ///For Message 2.0

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  checkIfMessageThreadExistsAndPush(
      String userId, String receiverId, String message) async {
    _firestore.collection('messages');
    final querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: userId)
        .where('receiverId', isEqualTo: receiverId)
        .get();

    final existingDoc =
        querySnapshot.docs.isEmpty ? null : querySnapshot.docs.first;

    if (existingDoc != null) {
      await existingDoc.reference.collection('messages').add({
        'senderId': userId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': Timestamp.now(),
      });
    } else {
      await _firestore.collection('messages').add({
        'senderId': userId,
        'receiverId': receiverId,
        'messages': [
          {
            'senderId': userId,
            'receiverId': receiverId,
            'message': message,
            'timestamp': Timestamp.now(),
          },
        ],
      });
    }
  }

  //Send Message Function
  sendAMessage(String senderId, String receiverId, String message) async {
    String chatId = '$senderId+$receiverId';
    CollectionReference messageCollection = _firestore.collection('messages');
    try {
      await messageCollection.doc(chatId).set({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': [
          {
            'senderId': senderId,
            'receiverId': receiverId,
            'message': message,
            'timestamp': Timestamp.now(),
          },
        ],
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      print('after doc.set in sendAMessage function');
      await getMessagesForDocumentId(chatId);
    } catch (e) {
      print('error sending message $e');
    }

  }

  List<MessageModel> messageList = [];
  getMessagesForDocumentId(String documentId) async {
    final querySnapshot = await _firestore
        .collection('messages')
        .doc(documentId)
        // .collection('message')
        // .orderBy('timestamp', descending: true)
        .get();
    print('getting querySnapShot ${querySnapshot}');

    try {
      List<MessageModel> list = [];
      final messageData = querySnapshot.data();
      list = (messageData!['message'] as List<dynamic>).map((message) => MessageModel.fromJson(message))
          .toList();
      messageList.addAll(list);
      print('messages is $messageList');
      notifyListeners();

    } catch (e) {
      print('error getting messages $e');
    }
  }
}
