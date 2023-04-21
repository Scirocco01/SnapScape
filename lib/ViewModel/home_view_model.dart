import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model_for_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/comments_model.dart';
import '../Model/feed_data_model.dart';
import '../Model/user_data_model.dart';

class HomeViewModel extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;





  //get userName for Home Page
  // _userNameForHomePage() async {
  //   try {
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid)
  //         .get();
  //     userName = userDoc.get('userName');
  //     notifyListeners();
  //   } catch (e) {
  //     print('error getting user Name $e');
  //     userName = 'error 41';
  //     notifyListeners();
  //   }
  // }

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

  // Future<String> _getPhotoFromStorage() async {
  //   try {
  //     Reference photoRef = FirebaseStorage.instance
  //         .refFromURL(await _getProfilePhotoFromFireStore(user!.uid));
  //     String downloadUrl = await photoRef.getDownloadURL();
  //     return downloadUrl;
  //   } catch (e) {
  //     print('error in firebase storage $e');
  //     return '';
  //   }
  // }

  // getProfilePhotoUrl() async {
  //   _userNameForHomePage();
  //   profilePhotoUrl = await _getPhotoFromStorage();
  //   // await saveImageToSharedPref(profilePhotoUrl,user!.uid);
  //   // saveImageToSharedPref(profilePhotoUrl, user!.uid);
  //   notifyListeners();
  //   print('getProfileFunc successfully executed photo uri is $profilePhotoUrl');
  // }

  /// to get save image in memory using shared prefs and cache_manage

  Future<void> saveImageToSharedPref(String imageUrl,String userName)async{
    try{
      var file = await DefaultCacheManager().getSingleFile(imageUrl);
      //convert to bytes
      List<int> imageByte = await file.readAsBytes();
      //save as bytes
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userImage',base64Encode(imageByte));
      prefs.setString('userName', userName);
    }
    catch(e){
      print('an error occurred saving image to shared prefs error is = $e');
    }
  }

  /// for message system

  //creating a collection for messages in firebase fireStore
  final CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('messages');


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
  searchUserName(String userName,String currentUser) async {
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

      for (var doc in querySnapshot.docs) {
        matchMakingUsers = doc.id;
      }
      if (matchMakingUsers.isEmpty) {
        userName = userName.substring(0, userName.length - 1);
      }
    } while (matchMakingUsers.isEmpty && userName.isNotEmpty);

    matchMakingUsers;
    print('this is the matchmaking list $matchMakingUsers');
    await _getUserById(matchMakingUsers,currentUser);
    notifyListeners();
  }

  // function which searches and gives user according to UserID
  _getUserById(String userIDList,String userName) async {
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
  List<String> allDocId = [];
  List<String> receiverId = [];

  List<MessageReceiverDataModel> messageReceivers = [];

  getAllDocumentIds(String mySenderId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .get();

    List<String> documentIds = [];
    for (var doc in snapshot.docs) {
      String docId = doc.id;
      List<String> ids = docId.split("+");
      if (ids[0] == mySenderId || ids[1] == mySenderId) {
        if(ids[0] == mySenderId){
          receiverId.add(ids[1]);
        }
        else{
          receiverId.add(ids[0]);
        }

        documentIds.add(docId);
        notifyListeners();
      }
    }

    allDocId = documentIds;
    notifyListeners();
  }



  Future<void> getMessageReceivers(List<String> receiverIDs) async {
    for(var i = 0;i<receiverIDs.length;i++){
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(receiverIDs[i])
          .get();

      if (doc.exists) {
        messageReceivers.add(MessageReceiverDataModel(
          name: doc['name'],
          userName: doc['userName'],
          profilePhotoUrl: doc['photoUrl'],
        ));


      } else {
        print('No document exists with ID ${receiverIDs[i]}');
      }
    }
    notifyListeners();
  }


  /// to show the feeds below are the Functions

  Future<List<String>> _fetchUserInfo(String userId) async {
    List<String> list = [];
    try {
      
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      String name = userDoc.get('name');
      String userName = userDoc.get('userName');
      String photoUrl = userDoc.get('photoUrl');

      list = [name,userName,photoUrl];


      return  list;

    } catch (e) {
      print('Error fetching user info: $e');
      return list;
    }
  }

  Future<List<FeedDataModel>> fetchFeedData() async {
    List<FeedDataModel> feedDataList = [];
    List<String> userInfo = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).get();

      for (var doc in querySnapshot.docs) {
        String docId = doc.id;
        List<String> parts = docId.split('+');
        String userId = parts[0];

        userInfo = await _fetchUserInfo(userId);

        
        if(userInfo.isEmpty) {


          FeedDataModel feedData = FeedDataModel(
            name: 'Sanan',
            nickName: 'sana_sk',
            profileUrl: 'https://1fid.com/wp-content/uploads/2022/06/Twitter-profile-picture-1024x1022.jpg',
            postUrl: doc['imageUrl'],
            likes: doc['likes'],
            comments: doc['comments'].length,
            caption: doc['caption'],
            timeStamp: (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
            postId: doc.id, userId: '',
          );
          feedDataList.add(feedData);
        }
        else{
          FeedDataModel feedData = FeedDataModel(
            name: userInfo[0],
            nickName: userInfo[1],
            profileUrl: userInfo[2],
            postUrl: doc['imageUrl'],
            likes: doc['likes'],
            comments: 1,
            caption: doc['caption'],
            timeStamp: (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
            postId: doc.id,
            userId: userId,
          );
          feedDataList.add(feedData);
        }
      }
    } catch (e) {
      print('Error fetching feed data: $e');
    }

    return feedDataList;
  }


  /// to like a post



  Future<void> incrementLikePost(String postId, String userId) async {
    final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

    // Increment the likes count by 1
    await postRef.update({'likes': FieldValue.increment(1)});

    // Add the user ID to the liked-by array
    await postRef.collection('liked-by').doc(userId).set(({
      'timeStamp': FieldValue.serverTimestamp(),
      'userId':userId
    }));
  }

  Future<void> decrementLikePost(String postId, String userId) async {
    final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);

    // Increment the likes count by 1
    await postRef.update({'likes': FieldValue.increment(-1)});

    // Add the user ID to the liked-by array
    await postRef.collection('liked-by').doc(userId).delete();
  }


  ///check for liked by

  Future<bool> checkForLikedBy(String postId,String userId)async{

    final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final DocumentSnapshot likeDoc = await postRef.collection('liked-by').doc(userId).get();

    return likeDoc.exists;

  }

  Future<List<String>> getCurrentUserDat() async {
    List<String> list = [];
    // Query the Firestore collection for the current user document
    final DocumentSnapshot userSnapshot =  await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    // Get the name and profile URL from the user document
    final String currentUserName = userSnapshot.get('name');
    final String currentUserProfileUrl = userSnapshot.get('photoUrl');
    list = [currentUserName,currentUserProfileUrl];
    return list;

  }






}
