import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/Model/user_data_model.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/text.dart';
import '../../Components/MessagingComponents/message_search_user_component.dart';
import '../../Components/MessagingComponents/message_thread.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();

  }




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
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8,right: 10,left: 10,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon:const  Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                ),
                onChanged: (value) {

                },
              ),
              const SizedBox(height: 10,),
              const PrimaryText(text: 'Messages'),
              SizedBox(

                width: SizeConfig.screenWidth! * 1,
                height: SizeConfig.screenHeight! * 0.9,
                child: ListView.builder(
                  itemCount: widget.model.messageReceivers.length,
                    itemBuilder: (context,index){
                    print('this is the tile widget.model.messageRec${widget.model.messageReceivers[index]}');
                      return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessageChatScreen(
                                  senderId: widget.model.user!.uid, receiverId:widget.model.receiverId[index],)
                              ),
                            );
                          },
                          child: buildChatTile(widget.model.messageReceivers[index],index));
                    }),
              )

            ],
          ),
        ),
      )
    );
  }
}


Widget buildChatTile(MessageReceiverDataModel model,int index) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(color:index % 2 == 0? Colors.purple:Colors.grey,width: 3),
            borderRadius:const BorderRadius.all(Radius.circular(32)),
            
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(model.profilePhotoUrl),
            radius: 30,
          ),
        ),
        const SizedBox(width: 10,),
        Column(
          children: [
            PrimaryText(text: model.name,fontWeight: FontWeight.w500,),
            PrimaryText(text: model.userName,color: Colors.grey,size: 14,),
          ],
        ),
        const Expanded(child: SizedBox()),
        IconButton(onPressed: (){},
            icon:const Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 30,) )
      ],
    ),
  );
}
