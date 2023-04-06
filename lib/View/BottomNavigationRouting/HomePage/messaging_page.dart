import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/text.dart';
import '../../Components/MessagingComponents/message_search_user_component.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({
    Key? key,
    required this.pageController,
    required this.model,
  }) : super(key: key);

  final PageController pageController;
  final HomeViewModel model;

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  if (widget.pageController.hasClients) {
                    widget.pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.decelerate);
                    print('should animate to home page');

                  }
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
             PrimaryText(
              text: widget.model.userName,
            ),

            const Expanded(child: SizedBox()),
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComposeNewMessageScreen(model:widget.model),
                ),
              );
            }, icon: const Icon(Icons.add,color: Colors.black,))
          ],
        ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            ),
            onChanged: (value) {

            },
          ),
        ],
      )
    );
  }
}


Widget buildChatScreen(String senderId, String receiverId,HomeViewModel model) {
  return StreamBuilder<QuerySnapshot>(

    stream: model.getMessagesStream(senderId, receiverId),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      final List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
      return ListView.builder(
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final message = messages[index].data();
          return ListTile(
            title: Text((message as Map<String, dynamic>)['messageText'] ?? ''),
            subtitle: Text((message)['timestamp'].toString() ?? ''),
          );
        },
      );
    },
  );
}
