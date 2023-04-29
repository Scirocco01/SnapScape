


import 'package:flutter/material.dart';

import '../../../Model/user_data_model_for_message.dart';

class ProfileFollowingList extends StatefulWidget {
  const ProfileFollowingList({Key? key, required this.userIdList}) : super(key: key);
  final List<String> userIdList;

  @override
  State<ProfileFollowingList> createState() => _ProfileFollowingListState();
}

class _ProfileFollowingListState extends State<ProfileFollowingList> {

  List<UserMessageModel> followersList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),


          ],
        ),
      ),
    );
  }
}
