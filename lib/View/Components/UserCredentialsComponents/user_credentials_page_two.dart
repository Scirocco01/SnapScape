

import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/text.dart';

class UserCredentialPageTwo extends StatefulWidget {
  final UserCredentialsViewModel viewModel;
  const UserCredentialPageTwo({
    Key? key, required this.viewModel,
  }) : super(key: key);

  @override
  State<UserCredentialPageTwo> createState() => _UserCredentialPageTwoState();
}

class _UserCredentialPageTwoState extends State<UserCredentialPageTwo> {



  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children:  [
           Container(
             decoration: BoxDecoration(
               borderRadius: const BorderRadius.all(Radius.circular(60)),
               border:Border.all(
                 color:Colors.black,
               )

             ),
             child: const CircleAvatar(
               backgroundColor: Colors.white,
               backgroundImage:  AssetImage('Assets/profile_photo_icon.png'),
               radius: 60,

                ),
           ),
          const SizedBox(height: 10,),
          
          const PrimaryText(text: 'Click Above to add Profile Photo')


        ],
    );
  }
}


