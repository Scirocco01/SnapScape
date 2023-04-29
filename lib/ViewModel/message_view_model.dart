import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Model/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageViewModel extends ChangeNotifier {




  Future<void> sendMessage(
      String senderId, String receiverId, String message) async {
    String chatId1 = '$senderId+$receiverId';
    String chatId2 = '$receiverId+$senderId';


    // Check if a document already exists for this chat
    DocumentSnapshot chatDoc1 =
        await FirebaseFirestore.instance.collection('chats').doc(chatId1).get();
    DocumentSnapshot chatDoc2 =
        await FirebaseFirestore.instance.collection('chats').doc(chatId2).get();

    // If document exists for senderId+receiverId, update the messages in that document
    if (chatDoc1.exists) {
      List<Map<String, dynamic>> messages =
          List<Map<String, dynamic>>.from(chatDoc1['messages']);
      messages.add({
        'text': message,
        'senderId': senderId,
        'receiverId': receiverId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId1).update({
        'messages': messages,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
      return;
    }

    // If document exists for receiverId+senderId, update the messages in that document
    if (chatDoc2.exists) {
      List<Map<String, dynamic>> messages =
          List<Map<String, dynamic>>.from(chatDoc2['messages']);
      messages.add({
        'text': message,
        'senderId': senderId,
        'receiverId': receiverId,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId2).update({
        'messages': messages,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
      return;
    }

    await FirebaseFirestore.instance.collection('chats').doc(chatId1).set({
      'participants': [senderId, receiverId],
      'messages': [
        {
          'text': message,
          'senderId': senderId,
          'receiverId': receiverId,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }
      ],
      'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
  }

  List<String> allDocId = [];
  String docId = '';

  getAllDocumentIds(String receiverId, String senderId) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('chats').get();
    List<String> documentIds = [];
    snapshot.docs.forEach((doc) {
      documentIds.add(doc.id);
    });
    allDocId = documentIds;
    docId = allDocId.firstWhere((element) =>
        (element == '$senderId+$receiverId' ||
            element == '$receiverId+$senderId'));
    notifyListeners();
  }




  Stream<DocumentSnapshot> getChatStream(String docID) {
    print('this is the Doc Id $docId');
    if(docId.isEmpty){
      docId = docID;
      notifyListeners();
    }
    var documentSnapshot =
        FirebaseFirestore.instance.collection('chats').doc(docId).snapshots();

    return documentSnapshot;
  }


  /// getImage from Shared Prefs

  Future<Uint8List?> getImageFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final base64Image = prefs.getString('profile_image');
    if (base64Image != null) {
      return base64Decode(base64Image);
    }
    return null;
  }

  /// save data in userDataModel of the receiver so it can be shown in a header

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  MessageReceiverDataModel messageReceiverDataModel = MessageReceiverDataModel(name: '', userName: '', profilePhotoUrl: '');

   getProfilePhotoFromFireStore(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      
      messageReceiverDataModel.profilePhotoUrl =  userDoc.get('photoUrl');
      messageReceiverDataModel.name = userDoc.get('name');
      messageReceiverDataModel.userName = userDoc.get('userName');
      notifyListeners();
    } catch (e) {
      print('error getting data form cloud fireStore $e');
      return '';
    }
  }
  

  



}
