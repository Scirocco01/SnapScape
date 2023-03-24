
import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialPageOne extends StatelessWidget {
  const UserCredentialPageOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PrimaryText(text: 'Enter User Name?',size:32, color:Colors.black,fontWeight: FontWeight.w500,),
        const SizedBox(height: 10,),
        const PrimaryText(text: 'This will not be public',color: Color(0xFFaaabba),),

        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border:Border.all(
                  color: Colors.black
              )
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0,right: 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Name',
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