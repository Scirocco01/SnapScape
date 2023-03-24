import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';

import '../../App/injectors.dart';

class UserCredentials extends StatefulWidget {
  const UserCredentials({Key? key}) : super(key: key);

  @override
  State<UserCredentials> createState() => _UserCredentialsState();
}

class _UserCredentialsState extends State<UserCredentials> {
  final UserCredentialsViewModel viewModel = injector<UserCredentialsViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFf2f7f9),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height:70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.g_mobiledata_rounded,color: Colors.greenAccent,size: 82,),
                ],
              ),
              const PrimaryText(text: 'Enter User Name?',size:32, color:Colors.black,fontWeight: FontWeight.w500,),
              SizedBox(height: 10,),
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
                height: SizeConfig.screenHeight! * 0.45,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFe65b0c),
                  shape:const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  )
                ),
                  onPressed: (){},
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0,bottom: 12.0),
                      child: PrimaryText(text: 'Next',color: Colors.white,size: 26,),
                    ),
                  )),

              const SizedBox(
                height: 10
              ),
              const PrimaryText(text: 'Do you already have an account?',color: Color(0xFF97a6b2),),
               TextButton(onPressed: (){},
                  child: const PrimaryText( text: 'Log In',color: Colors.blueAccent,),)
        ]),)
    );
  }
}
