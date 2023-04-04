
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialsPageThree extends StatefulWidget {
  const UserCredentialsPageThree({
    Key? key, required this.model,
  }) : super(key: key);
  final UserCredentialsViewModel model;

  @override
  State<UserCredentialsPageThree> createState() => _UserCredentialsPageThreeState();
}

class _UserCredentialsPageThreeState extends State<UserCredentialsPageThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PrimaryText(text: 'Create your account',size:32, color:Colors.black,fontWeight: FontWeight.w500,),


        const SizedBox(
          height: 30,
        ),
        dataEntryWidget('Enter a User Name',widget.model,1),
        const SizedBox(
          height: 15,
        ),
        dataEntryWidget('Number or Email',widget.model,2),
        const SizedBox(
          height: 15,
        ),

        dataEntryWidget('write your bio@',widget.model,3),
        const SizedBox(
          height: 15,
        ),

        SizedBox(
          height: SizeConfig.screenHeight! * 0.25,
        ),
      ],
    );
  }

  Container dataEntryWidget(String hintText,UserCredentialsViewModel model,int num){
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border:Border.all(
                color: Colors.black
            )
        ),
        child:  Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 4),
          child: TextField(
            onChanged: (val){
              switch(num){
                case 1:{
                  model.selectUserName(val);
                }
                break;
                case 2:{

                }
                break;
                case 3:{
                  model.selectBio(val);
                }
              }

            },
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      );
  }
}