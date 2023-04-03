
import 'package:ehisaab_2/View/Components/Validators/validators.dart';
import 'package:flutter/material.dart';

import '../../../Config/size_config.dart';
import '../../../Config/text.dart';

class UserCredentialPageOne extends StatelessWidget {
   const UserCredentialPageOne({
     required this.validatorKey,
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> validatorKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Column(
      children: [
        const PrimaryText(text: 'Enter User Name?',size:32, color:Colors.black,fontWeight: FontWeight.w500,),
        const SizedBox(height: 10,),
        const PrimaryText(text: 'This will  be public',color: Color(0xFFaaabba),),

        const SizedBox(
          height: 30,
        ),
        TextFormField(
              validator: validateName,
              
              decoration:  const InputDecoration(

                contentPadding: EdgeInsets.all(8),
                errorBorder: OutlineInputBorder(
                  borderSide:BorderSide(
                    color: Colors.redAccent,
                    width: 2
                  )
                ),
                hintText: 'Enter Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),

              ),
            ),

        SizedBox(
          height: SizeConfig.screenHeight! * 0.40,
        ),
      ],
    ));
  }
}