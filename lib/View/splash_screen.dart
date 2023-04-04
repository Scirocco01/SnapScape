import 'package:ehisaab_2/View/login_screen.dart';
import 'package:flutter/material.dart';

import '../Config/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    // Simulate a delay of 3 seconds before showing the main screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight! * 1,
      width: SizeConfig.screenWidth! * 1,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image:AssetImage('Assets/splash.png'),
                fit:BoxFit.fill,

        )
      ),
    );
  }
}
