


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AddPostViewModel extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<String> _addPostToFireBaseStorage(File image)async{
    try{
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('posts/ ${user!.uid}+${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      return taskSnapshot.ref.getDownloadURL();

    }catch(e){
      print('error storing post to storage firebase');
      return '';
    }
  }

  Future<void> savePost(File image, String caption) async {
    CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');
    final imageUrl = await _addPostToFireBaseStorage(image);
      try{
        postsRef.add({
          'imageUrl': imageUrl,
          'caption': caption,
          'comments': [], // Initialize as an empty list
          'liked-by': <String>[],
          'likes': 0, // Initialize as 0
          'totalShares': 0, // Initialize as 0
          'timestamp': FieldValue.serverTimestamp(),
          'userID': user!.uid// Set the server timestamp
          // Add other fields, like 'userId', etc.
        });

      }catch(e){
        print('error occurred $e');
      }
  }



}

class Comment {
  String userId;
  String text;

  Comment({required this.userId, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'text': text,
    };
  }
}