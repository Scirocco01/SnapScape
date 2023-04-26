


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
    String documentId = '${user!.uid}+${DateTime.now().millisecondsSinceEpoch}';

    final imageUrl = await _addPostToFireBaseStorage(image);
    try {
      // Use the 'doc()' method to create a reference to a document with the custom ID
      DocumentReference docRef = postsRef.doc(documentId);

      // Set the document data using 'set()' instead of 'add()'
      await docRef.set({
        'imageUrl': imageUrl,
        'caption': caption,
        'likes': 0, // Initialize as 0
        'comments':0,
        'totalShares': 0, // Initialize as 0
        'timestamp': FieldValue.serverTimestamp(),
        'userID': user!.uid // Set the server timestamp

      });
      CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
      DocumentReference userDocRef = usersRef.doc(user!.uid);
      await userDocRef.update({'postCount': FieldValue.increment(1)});
      CollectionReference userPostsRef = userDocRef.collection('posts');
      await userPostsRef.add({
        'postId': documentId});
    } catch (e) {
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