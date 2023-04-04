import 'package:ehisaab_2/View/splash_screen.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App/injectors.dart';
import 'View/login_screen.dart';
import 'ViewModel/navigation_provider_view_model.dart';
import 'firebase_options.dart';




Future<void> main() async {
  await initDependencies();
  runApp(
    const MyApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);




}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,

  });


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HomeViewModel viewModel = injector<HomeViewModel>();

  @override
  void initState() {

    viewModel.changeNum(7);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
