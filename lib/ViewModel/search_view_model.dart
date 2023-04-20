


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Model/feed_data_model.dart';

class SearchViewModel extends ChangeNotifier{





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

  List<FeedDataModel> feedDataList = [];

   fetchFeedData() async {

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
          notifyListeners();
        }
        else{
          FeedDataModel feedData = FeedDataModel(
            name: userInfo[0],
            nickName: userInfo[1],
            profileUrl: userInfo[2],
            postUrl: doc['imageUrl'],
            likes: doc['likes'],
            comments: doc['comments'].length,
            caption: doc['caption'],
            timeStamp: (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
            postId: doc.id,
            userId: userId,
          );
          feedDataList.add(feedData);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching feed data: $e');
    }


  }



}