

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Constants/firebase_constants.dart';

class MessageViewModel extends ChangeNotifier{


  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    String chatId1 = '$senderId+$receiverId';
    String chatId2 = '$receiverId+$senderId';



    // Check if a document already exists for this chat
    DocumentSnapshot chatDoc1 = await FirebaseFirestore.instance.collection('chats').doc(chatId1).get();
    DocumentSnapshot chatDoc2 = await FirebaseFirestore.instance.collection('chats').doc(chatId2).get();

    // If document exists for senderId+receiverId, update the messages in that document
    if (chatDoc1.exists) {
      List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(chatDoc1['messages']);
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
      List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(chatDoc2['messages']);
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

   getAllDocumentIds(String receiverId,String senderId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('chats').get();
    List<String> documentIds = [];
    snapshot.docs.forEach((doc) {
      documentIds.add(doc.id);
    });
     allDocId = documentIds;
     docId = allDocId.firstWhere((element) => (element == '$senderId+$receiverId' || element == '$receiverId+$senderId'));
     print('this is the current doc ID, $docId');
     notifyListeners();
  }


  Stream<DocumentSnapshot> getChatStream() {


    var documentSnapshot  =  FirebaseFirestore.instance.collection('chats').doc(docId).snapshots();

    return documentSnapshot;

  }


  User? user = FirebaseAuth.instance.currentUser;
  bool _checkDocumentSnapshot(String senderId,Stream<DocumentSnapshot> doc){
   if(user?.uid == senderId ){
     print('returning true uid == senderId');
     return true;
   }
   else{
     print('returning false Uid != senderId');
     return false;
   }
  }


}