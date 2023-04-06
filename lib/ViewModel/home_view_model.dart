import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model_for_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';



class HomeViewModel extends ChangeNotifier {
  
  
  User? user = FirebaseAuth.instance.currentUser;
  
  
  String userId = '';

  String profilePhotoUrl = '';
  String userName = '';


  //get userName for Home Page
  _userNameForHomePage() async {
    
    try{
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          'users').doc(user!.uid).get();
      userName = userDoc.get('userName');
      notifyListeners();
    }catch(e){
      print('error getting user Name $e');
      userName = 'error 09032293';
      notifyListeners();
      
    }
  }


  

  /// for User Data like name and profile Photo

  Future<String> _getProfilePhotoFromFireStore(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          'users').doc(userId).get();
      
      notifyListeners();
      return userDoc.get('photoUrl');
    }
    catch (e) {
      print('error getting data form cloud fireStore $e');
      return '';
    }
  }


  Future<String> _getPhotoFromStorage() async {
    try {
      Reference photoRef = FirebaseStorage.instance.refFromURL(
          await _getProfilePhotoFromFireStore(user!.uid));
      String downloadUrl = await photoRef.getDownloadURL();
      return downloadUrl;
    }
    catch (e) {
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
  final CollectionReference messageCollection = FirebaseFirestore.instance
      .collection('messages');

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
    final List<String> matchMakingUsers = [];
    QuerySnapshot querySnapshot;

    do {
      querySnapshot = await FirebaseFirestore.instance.collection('users')
          .where('userName', isGreaterThanOrEqualTo: userName)
          .where('userName', isLessThan: '${userName}z')
          .get();

      querySnapshot.docs.forEach((doc) {
        matchMakingUsers.add(doc.id);
      });
      if (matchMakingUsers.isEmpty) {
        userName = userName.substring(0, userName.length - 1);
      }
    } while (matchMakingUsers.isEmpty && userName.isNotEmpty);

    userIdListForMessageSearch = matchMakingUsers;
    _getUserById(userIdListForMessageSearch);
    notifyListeners();
  }

  // function which searches and gives user according to UserID
   _getUserById(List<String>  userIDList) async {
    for(var i = 0; i<userIDList.length;i++){
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          'users').doc(userId).get();

      if (userDoc.exists) {
       userListForMessage.add(
           UserMessageModel(
          profilePic: await _getProfilePhotoFromFireStore(userId),
          fullName: userDoc.get('name'),
          userName: userDoc.get('userName'),
        ));
       notifyListeners();
      } else {
        throw Exception('User not found');
      }

    }
  }






}