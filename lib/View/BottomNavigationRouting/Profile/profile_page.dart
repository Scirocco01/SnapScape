


import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({Key? key, required this.setupPageRoute}) : super(key: key);
  final String setupPageRoute;

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case "dashboard/profile":
        page = const ProfilePage();
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.lock,color: Colors.grey,),
            const PrimaryText(text: 'User_Name',fontWeight: FontWeight.w500,),
            const Expanded(
              child: SizedBox(),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_box,
                  size: 30,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.grey,
                )),

          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0,top: 18,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://e1.pxfuel.com/desktop-wallpaper/270/669/desktop-wallpaper-blue-fade-gradient-by-hk3ton-color-fade-thumbnail.jpg'),

                    ),
                    SizedBox(height: 10,),

                    PrimaryText(text: 'UserName',size: 16,fontWeight: FontWeight.w500,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(text: '6',fontWeight: FontWeight.bold,),
                    PrimaryText(text: 'Posts')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(text: '160',fontWeight: FontWeight.bold,),
                    PrimaryText(text: 'Followers')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(text: '157',fontWeight: FontWeight.bold,),
                    PrimaryText(text: 'Following')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

