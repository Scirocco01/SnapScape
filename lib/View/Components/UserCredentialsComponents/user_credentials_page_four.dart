


import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialPageFour extends StatefulWidget {
  const UserCredentialPageFour({
    Key? key,
  }) : super(key: key);

  @override
  State<UserCredentialPageFour> createState() => _UserCredentialPageFourState();
}

class _UserCredentialPageFourState extends State<UserCredentialPageFour> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PrimaryText(text: 'choose a Password',size:32, color:Colors.black,fontWeight: FontWeight.w500,),
        const SizedBox(height: 10,),
        const PrimaryText(text: '6 characters minimum for password',color: Color(0xFFaaabba),),

        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border:Border.all(
                  color: Colors.black
              )
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0,right: 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        SizedBox(
          height: SizeConfig.screenHeight! * 0.40,
        ),
      ],
    );
  }
}