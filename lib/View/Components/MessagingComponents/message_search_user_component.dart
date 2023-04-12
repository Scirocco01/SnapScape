

import 'package:ehisaab_2/Model/user_data_model_for_message.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Config/text.dart';
import 'message_thread.dart';

class ComposeNewMessageScreen extends StatefulWidget {
  const ComposeNewMessageScreen({Key? key, required this.model})
      : super(key: key);

  final HomeViewModel model;

  @override
  State<ComposeNewMessageScreen> createState() =>
      _ComposeNewMessageScreenState();
}

class _ComposeNewMessageScreenState extends State<ComposeNewMessageScreen> {



  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => widget.model,
        child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const PrimaryText(
                      text: 'New Message',
                      fontWeight: FontWeight.w500,
                    ),
                    const Expanded(child: SizedBox()),
                    const PrimaryText(
                      text: 'Chat',
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, top: 10, right: 16, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrimaryText(
                      text: 'To',
                      fontWeight: FontWeight.w400,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          // filled: true,
                          // fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                        ),
                        onChanged: (value) async {
                            await model.searchUserName(value);
                            if(value == ''){
                              model.emptyUserListForMessage();
                            }

                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 400,
                      width: 400,
                      child: model.userListForMessage.isNotEmpty
                          ?
                      ListView.builder(
                              itemCount: widget.model.userListForMessage.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      visibility = !visibility;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (BuildContext context) =>
                                          MessageChatScreen(
                                            senderId: model.user!.uid,
                                            receiverId:model.userListForMessage[index].searchedUserId ),
                                        ));

                                    });
                                  },
                                  child: SearchSuggestionsWidget(
                                    userMessageModel:
                                        widget.model.userListForMessage[index],
                                    user: (user ) {
                                     //don't need this line of code to execute
                                    },
                                    visibility: visibility,
                                  ),
                                );
                              })
                          : const CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            )));
  }
}

class SearchSuggestionsWidget extends StatefulWidget {
   SearchSuggestionsWidget({
    Key? key,
    required this.userMessageModel,
    required this.user, required this.visibility,
  }) : super(key: key);

  final UserMessageModel userMessageModel;
  final Function(UserMessageModel) user;
  bool visibility;

  @override
  State<SearchSuggestionsWidget> createState() =>
      _SearchSuggestionsWidgetState();
}

class _SearchSuggestionsWidgetState extends State<SearchSuggestionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.userMessageModel.profilePic),
            radius: 32
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(text: widget.userMessageModel.fullName, size: 16,),
              PrimaryText(text: widget.userMessageModel.userName, size: 16,color: Colors.grey,)
            ],
          ),
          const Expanded(child:SizedBox(),),

          Container(
            height: 35,
            width: 35,
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35)),
              border: Border.all(color: widget.visibility?Colors.white:Colors.grey,width: 2),
              color: widget.visibility?Colors.blue:Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Visibility(
                visible: widget.visibility,
                child: const Icon(Icons.check,color: Colors.white,),
              ),
            ),

          )


        ],
      ),
    );
  }
}
