import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/View/Components/UserCredentialsComponents/user_credentials_page_two.dart';
import 'package:ehisaab_2/ViewModel/user_credentials_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../App/injectors.dart';
import '../Components/UserCredentialsComponents/user_credential_page_one.dart';

class UserCredentials extends StatefulWidget {
  const UserCredentials({Key? key}) : super(key: key);

  @override
  State<UserCredentials> createState() => _UserCredentialsState();
}

class _UserCredentialsState extends State<UserCredentials> {
  final UserCredentialsViewModel viewModel = injector<UserCredentialsViewModel>();
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
                height: SizeConfig.screenHeight! * 0.64,
                child: PageView(
                  controller: _pageController,
                  children:  [

                    const UserCredentialPageOne(),
                    UserCredentialPageTwo(viewModel: model,)
                  ],
                ),

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
    )));
  }
}


