import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App/injectors.dart';
import 'View/login_screen.dart';
import 'ViewModel/navigation_provider_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final client = StreamChatClient(
  //   'ktvbkbhgzmsa',
  //   logLevel: Level.INFO,
  // );

  // await client.connectUser(User(id: 'todoklikkers'),
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidG9kb2tsaWtrZXJzIn0.sQojN1XljG2v7F2U8Zl1WoDrdyBOb08xThrZE4vTqoE');
  // final channel = client.channel('messaging', id: 'flutterdevs');
  // channel.watch();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MyApp(
          // channel: channel,
          // client: client,
          ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    //  required this.client,
    //  required this.channel
  });
  // final StreamChatClient client;
  // final Channel channel;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HomeViewModel viewModel = injector<HomeViewModel>();

  @override
  void initState() {
    // viewModel.assignChannel(widget.channel);
    // viewModel.assignClient(widget.client);
    viewModel.changenum(7);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
          // channel: widget.channel,
          // client: widget.client,
          ),
    );
  }
}
