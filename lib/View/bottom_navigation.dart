import 'package:ehisaab_2/View/BottomNavigationRouting/AddPost/add_post.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/HomePage/home_page.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Notifications/notifications.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Profile/profile_page.dart';
import 'package:ehisaab_2/View/login_screen.dart';
import 'package:ehisaab_2/ViewModel/navigation_provider_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../App/injectors.dart';

import 'BottomNavigationRouting/Search/search_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final NavigationProvider viewModel = injector<NavigationProvider>();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    SearchPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
    Text(
      'Index 4: Settings',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavigationProvider>(
        create: (context) => viewModel,
        child: Consumer<NavigationProvider>(
            builder: (context, model, child) => Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (model.currentTab == 'home')
                      const HomePageRoute(setupPageRoute: "dashboard/home"),
                    if (model.currentTab == 'search')
                      const SearchPageRoute(setupPageRoute: "dashboard/search"),
                    if(model.currentTab == 'notifications')
                      const NotificationsRoute(setupPageRoute: 'dashboard/notifications'),
                    if(model.currentTab == 'profile')
                      const ProfileRoute(setupPageRoute: 'dashboard/profile'),
                    if(model.currentTab == 'addPost')
                      const AddPostRoute(setupPageRoute: 'dashboard/addPost'),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top:
                                  BorderSide(color: Colors.black, width: 0.1))),
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    model.changeCurrentTabTo('home');
                                  },
                                  icon: const Icon(
                                    Icons.home,
                                    size: 30,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    model.changeCurrentTabTo('search');

                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    size: 30,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    model.changeCurrentTabTo('addPost');
                                  },
                                  icon: const Icon(
                                    Icons.add_box,
                                    size: 30,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    model.changeCurrentTabTo('notifications');
                                  },
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    size: 30,

                                  )),
                              GestureDetector(
                                onTap: () {
                                  model.changeCurrentTabTo('profile');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                                    border: Border.all(color: model.currentTab == 'profile'?Colors.black:Colors.white,width: 2)
                                  ),
                                  child: const CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage('https://e1.pxfuel.com/desktop-wallpaper/270/669/desktop-wallpaper-blue-fade-gradient-by-hk3ton-color-fade-thumbnail.jpg'),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ))));

    //               bottomNavigationBar: BottomNavigationBar(
    //                 type: BottomNavigationBarType.fixed,
    //                 showSelectedLabels: false,
    //                 selectedIconTheme: const IconThemeData(
    //                   color: Colors.black,
    //                 ),
    //                 unselectedIconTheme: const IconThemeData(color: Colors.grey),
    //                 iconSize: 30,
    //                 showUnselectedLabels: false,
    //                 backgroundColor: Colors.white,
    //                 items: const [
    //                   BottomNavigationBarItem(
    //                     icon: Icon(
    //                       Icons.home,
    //                     ),
    //                     label: '',
    //                     backgroundColor: Colors.black,
    //                   ),
    //                   BottomNavigationBarItem(
    //                     icon: Icon(Icons.search),
    //                     label: '',
    //                     backgroundColor: Colors.black,
    //                   ),
    //                   BottomNavigationBarItem(
    //                     icon: Icon(Icons.add_box),
    //                     label: '',
    //                     backgroundColor: Colors.black,
    //                   ),
    //                   BottomNavigationBarItem(
    //                     icon: Icon(Icons.video_camera_back_outlined),
    //                     label: '',
    //                     backgroundColor: Colors.white,
    //                   ),
    //                   BottomNavigationBarItem(
    //                     icon: Icon(Icons.notifications),
    //                     label: '',
    //                     backgroundColor: Colors.black,
    //                   ),
    //                 ],
    //                 currentIndex: _selectedIndex,
    //                 selectedItemColor: Colors.amber[800],
    //                 unselectedItemColor: Colors.white,
    //                 onTap: _onItemTapped,
    //               ))));
  }
}
