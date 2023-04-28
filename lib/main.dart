import 'package:ehisaab_2/View/splash_screen.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'App/injectors.dart';
import 'View/login_screen.dart';
import 'ViewModel/navigation_provider_view_model.dart';
import 'firebase_options.dart';


//init dynamic link
Future<void> initDynamicLink() async {
  final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
  if (instanceLink != null) {
    final Uri refLink = instanceLink.link;
    Share.share('this is the link ${refLink.data}');
  }

  FirebaseDynamicLinks.instance.onLink;
}


Future<void> main() async {
  await initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initDynamicLink();
  runApp(
    const MyApp(),
  );


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



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
