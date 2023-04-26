import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehisaab_2/View/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    Future.delayed(const Duration(seconds: 6), () {
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
      height: SizeConfig.screenHeight! * 0.2,
      width: SizeConfig.screenWidth! * 0.2,
      color: Colors.black,
      child: Image.asset(
        'Assets/139658-rivals-loading.gif',
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      )
    );
  }
}


