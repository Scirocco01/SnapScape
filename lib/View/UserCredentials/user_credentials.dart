import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/View/Components/UserCredentialsComponents/user_credentials_page_two.dart';
import 'package:ehisaab_2/View/bottom_navigation.dart';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../App/injectors.dart';
import '../Components/UserCredentialsComponents/user_credential_page_one.dart';
import '../Components/UserCredentialsComponents/user_credentials_page_four.dart';
import '../Components/UserCredentialsComponents/user_credentials_page_three.dart';

class UserCredentials extends StatefulWidget {
  const UserCredentials({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  State<UserCredentials> createState() => _UserCredentialsState();
}

class _UserCredentialsState extends State<UserCredentials> {
  final UserCredentialsViewModel viewModel = injector<UserCredentialsViewModel>();
  final GlobalKey<FormState> _key = GlobalKey();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  ChangeNotifierProvider<UserCredentialsViewModel>(
        create: (context) => viewModel,
        child: Consumer<UserCredentialsViewModel>(
        builder: (context, model, child) =>Scaffold(
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
              SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.62,
                child: PageView(
                  controller: _pageController,
                  children:  [

                     Form(
                       key:_key,
                         child: UserCredentialPageOne(validatorKey: _key,model: model,)),

                    UserCredentialPageTwo(viewModel: model,),

                     UserCredentialsPageThree(model: model,),
                  ],
                ),

              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFe65b0c),
                  shape:const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  )
                ),
                  onPressed: (){
                    model.pageNumber();
                  if(_pageController.hasClients ){
                    _pageController.animateToPage(model.pageNum,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.decelerate);

                  }
                  if(model.pageNum > 3 ){
                    model.callSaveData(widget.user);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const BottomNavigation()));
                  }

                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                      child:model.pageNum >= 2?
                      const PrimaryText(text: 'Register',color: Colors.white,size: 26,) :
                      const PrimaryText(text: 'Next',color: Colors.white,size: 26,),
                    ),
                  )),

              const SizedBox(
                height: 10
              ),
              const PrimaryText(text: 'Do you already have an account?',color: Color(0xFF97a6b2),size: 12,),
               TextButton(onPressed: (){},
                  child: const PrimaryText( text: 'Log In',color: Colors.blueAccent,size: 12,),)
        ]),)
    )));
  }
}


