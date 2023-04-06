



import 'package:ehisaab_2/Model/user_data_model_for_message.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/text.dart';

class ComposeNewMessageScreen extends StatefulWidget {
  const ComposeNewMessageScreen({Key? key, required this.model}) : super(key: key);

  final HomeViewModel model;

  @override
  State<ComposeNewMessageScreen> createState() => _ComposeNewMessageScreenState();

}

class _ComposeNewMessageScreenState extends State<ComposeNewMessageScreen> {
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
                  Navigator.pop(context);
                  },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const SizedBox(width: 10,),
            const PrimaryText(text:'New Message',fontWeight: FontWeight.w500,),
            const Expanded(child: SizedBox()),
            const PrimaryText(text: 'Chat',color: Colors.grey,),

          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 24.0,top: 10,right: 16,bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrimaryText(text: 'To',fontWeight: FontWeight.w400,size: 18,),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
                onChanged: (value) {
                  widget.model.searchUserName(value);
                },
              ),
            ),
            const SizedBox(height: 10,),
            widget.model.userListForMessage.isEmpty?
                const SizedBox(
                  height: 400,
                  child:  Center(
                    child: CircularProgressIndicator(),
                  ),
                ):
                SizedBox(
                  height: 400,
                  width: 400,
                  child:ListView.builder(
                    itemCount: widget.model.userListForMessage.length,
                      itemBuilder:(BuildContext context,index){
                        return SearchSuggestionsWidget(
                            userMessageModel: widget.model.userListForMessage[index],
                        );
                      })
                )



          ],
        ),
      ),
    );
  }
}

class SearchSuggestionsWidget extends StatelessWidget {
  const SearchSuggestionsWidget({
    Key? key, required this.userMessageModel,
  }) : super(key: key);

  final UserMessageModel userMessageModel;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userMessageModel.profilePic),
          radius: 40,
        ),
        const SizedBox(width: 10,),
        Column(
          children: [
            PrimaryText(text: userMessageModel.fullName),
            PrimaryText(text: userMessageModel.userName)
          ],
        )
      ],
    );
  }
}






