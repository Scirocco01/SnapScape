import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/ViewModel/message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../App/injectors.dart';

class MessageChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const MessageChatScreen(
      {super.key,
    required this.senderId,
    required this.receiverId
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageChatScreen> {
  late TextEditingController _textEditingController;
  final MessageViewModel viewModel = injector<MessageViewModel>();
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    viewModel.getProfilePhotoFromFireStore(widget.receiverId);
    viewModel.getAllDocumentIds(widget.receiverId,widget.senderId);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageViewModel>(
        create: (context) => viewModel,
        child: Consumer<MessageViewModel>(
            builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
                  appBar: AppBar(
                      iconTheme:const  IconThemeData(
                        color: Colors.black, // Set the color of the back button here
                      ),
                    backgroundColor: Colors.white,
                    elevation: 1,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.messageReceiverDataModel.profilePhotoUrl),
                        ),
                       const  SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(text: model.messageReceiverDataModel.name,fontWeight: FontWeight.w500,),
                            const PrimaryText(text: 'Active 2m ago',size: 12,color: Colors.grey,),
                          ],
                        )
                      ],
                    )
                  ),
                  body: StreamBuilder<DocumentSnapshot>(
                    stream:model.getChatStream('${widget.senderId}+${widget.receiverId}'),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final chatDoc = snapshot.data!;

                      final List<Map<String, dynamic>> messages = chatDoc.exists
                          ? List<Map<String, dynamic>>.from(chatDoc['messages'])
                          : [];
                      print('these are the messages $messages');
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollToBottom();
                      });


                      return Column(
                        children: [

                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              reverse: false,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final isSender =
                                    message['senderId'] == widget.senderId;
                                final bubbleColor =
                                    isSender ? const Color(0xffeaeaea) : Colors.white;
                                final bubbleAlignment = isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft;

                                return Align(
                                    alignment: bubbleAlignment,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: bubbleColor,
                                        border: Border.all(color:isSender? Colors.white:Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        message.isEmpty
                                            ? 'nothing to show'
                                            : message['text'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 2.0,bottom: 2,right: 4,left: 4),
                              decoration: BoxDecoration(
                                borderRadius:const  BorderRadius.all(Radius.circular(24)),
                                border: Border.all(color: Colors.black)
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:Colors.blue,
                                    child: Center(
                                      child: Icon(Icons.camera_alt_outlined,color: Colors.white,),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: TextField(
                                      controller: _textEditingController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter Message'
                                      ),
                                      onSubmitted: (value) {
                                        model.sendMessage('sender_id',
                                            widget.receiverId, value);
                                        setState(() {
                                          _textEditingController.text = '';
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () async {
                                      await model.sendMessage(
                                          widget.senderId,
                                          widget.receiverId,
                                          _textEditingController.text);
                                      setState(() {
                                        _textEditingController.text = '';
                                      });
                                    },
                                    child: const Text('Send'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )));
  }
}
