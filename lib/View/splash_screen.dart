import 'package:ehisaab_2/View/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Config/size_config.dart';
import 'bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Simulate a delay of 3 seconds before showing the main screen
  //   Future.delayed(Duration(seconds: 3), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );
  //   });
  // }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight! * 1,
      width: SizeConfig.screenWidth! * 1,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('Assets/splash.png'),
        fit: BoxFit.fill,
      )),
    );
  }
}

//
// Container(
// height: SizeConfig.screenHeight! * 1,
// width: SizeConfig.screenWidth! * 1,
// decoration: const BoxDecoration(
// image: DecorationImage(
// image:AssetImage('Assets/splash.png'),
// fit:BoxFit.fill,
//
// )
// ),
// );
