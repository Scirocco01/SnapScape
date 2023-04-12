import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/ViewModel/message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../App/injectors.dart';

class MessageChatScreen extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const MessageChatScreen({required this.senderId, required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageChatScreen> {
  late TextEditingController _textEditingController;
  final MessageViewModel viewModel = injector<MessageViewModel>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    viewModel.getAllDocumentIds(widget.receiverId,widget.senderId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageViewModel>(
        create: (context) => viewModel,
        child: Consumer<MessageViewModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    title: Text(widget.receiverId),
                  ),
                  body: StreamBuilder<DocumentSnapshot>(
                    stream:model.getChatStream(),
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
                      print('these are the messages ${messages}');


                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: false,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final isSender =
                                    message['senderId'] == widget.senderId;
                                final bubbleColor =
                                    isSender ? Colors.blue : Colors.grey[300];
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        message == null || message.isEmpty
                                            ? 'nothing to show'
                                            : message['text'].toString(),
                                        style: TextStyle(
                                          color: isSender
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _textEditingController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter message',
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
                                SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () async {
                                    await model.sendMessage(
                                        widget.senderId,
                                        widget.receiverId,
                                        _textEditingController.text);
                                    setState(() {
                                      _textEditingController.text = '';
                                    });
                                  },
                                  child: Text('Send'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )));
  }
}
