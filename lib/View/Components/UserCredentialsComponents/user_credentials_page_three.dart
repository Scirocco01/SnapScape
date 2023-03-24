
import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialsPageThree extends StatefulWidget {
  const UserCredentialsPageThree({
    Key? key,
  }) : super(key: key);

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
        dataEntryWidget('Enter Name'),
        const SizedBox(
          height: 15,
        ),
        dataEntryWidget('Number or Email'),
        const SizedBox(
          height: 15,
        ),
        dataEntryWidget('Nick Name'),
        const SizedBox(
          height: 15,
        ),

        SizedBox(
          height: SizeConfig.screenHeight! * 0.25,
        ),
      ],
    );
  }

  Container dataEntryWidget(String hintText) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border:Border.all(
                color: Colors.black
            )
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 8.0,right: 4),
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      );
  }
}