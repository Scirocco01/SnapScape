
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Model/comments_model.dart';



class CommentsViewModel extends ChangeNotifier{

  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;


  Future<void> saveComment(CommentsModel comment) async {
    final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(comment.postId);
    final CollectionReference commentsRef = postRef.collection('comments');

    await commentsRef.add({
      'userId': comment.userId,
      'username': comment.username,
      'avatarUrl': comment.avatarUrl,
      'text': comment.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// get all comments for a certain post

  List<CommentsModel> commentsList = [];

  Future<List<CommentsModel>> getCommentsForPost(String postId) async {
    try {
      final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
      final CollectionReference commentsRef = postRef.collection('comments');

      QuerySnapshot querySnapshot = await commentsRef.orderBy('timestamp', descending: true).get();

      List<CommentsModel> commentList = [];

      for (var doc in querySnapshot.docs) {
        commentList.add(
          CommentsModel(
            postId: postId,
            userId: doc['userId'],
            username: doc['username'],
            avatarUrl: doc['avatarUrl'],
            text: doc['text'],
            timestamp: doc['timestamp'].toDate(),
          ),
        );
      }

      commentsList = commentList;
      return commentList;
      notifyListeners();
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }




}