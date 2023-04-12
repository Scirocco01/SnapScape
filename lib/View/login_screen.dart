import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/HomePage/home_page.dart';
import 'package:ehisaab_2/View/bottom_navigation.dart';
import 'package:ehisaab_2/ViewModel/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../App/injectors.dart';
import '../Config/text.dart';
import 'UserCredentials/user_credentials.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, })
      : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthViewModel viewModel = injector<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<AuthViewModel>(
        create: (context) => viewModel,
        child: Consumer<AuthViewModel>(
            builder: (context, model, child) => Scaffold(
                backgroundColor: const Color(0xFFf2f7f9),
                body: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          PrimaryText(
                            text: 'ToDo',
                            color: Color(0xFF35499a),
                            size: 30,
                            fontWeight: FontWeight.w700,
                          ),
                          PrimaryText(
                            text: 'KliKKers',
                            color: Color(0xFFea8136),
                            size: 30,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      const PrimaryText(
                        text: 'Loreem Ipsum \n dolor sit amet',
                        color: Color(0xFF696a6a),
                        size: 40,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10),
                      const PrimaryText(
                          text: 'Share your story connect to Hive!',
                          color: Color(0xFF95a4b0)),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                          elevation: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () async {
                            final User? googleUser = await model.signInWithGo();

                              if(googleUser != null){
                                 Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                     BottomNavigation()));
                                print('signInFailed');
                              }
                              else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserCredentials(user: model.user,)));
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: Colors.greenAccent,
                                      size: 32,
                                    ),
                                    PrimaryText(
                                      text: 'register through google',
                                      color: Color(0xFF949494),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                          elevation: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {},
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: Colors.greenAccent,
                                      size: 32,
                                    ),
                                    PrimaryText(
                                      text: 'Register with Apple',
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                          elevation: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {},
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: Colors.greenAccent,
                                      size: 32,
                                    ),
                                    PrimaryText(
                                      text: 'Register through Mobile ',
                                      color: Color(0xFF949494),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          PrimaryText(
                            text: 'Already a user? ',
                            color: Color(0xFF9dacb7),
                          ),
                          PrimaryText(
                            text: 'Log In.',
                            color: Color(0xFF4baada),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
