


import 'package:flutter/material.dart';

import 'BottomNavigationRouting/HomePage/home_page.dart';
import 'BottomNavigationRouting/Search/search_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar:  BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            selectedIconTheme: IconThemeData(
              color: Colors.black,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey),
            iconSize: 30,
            showUnselectedLabels: false,

            backgroundColor: Colors.white,
            items: const[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                label: '',
                backgroundColor: Colors.black,


              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
                backgroundColor: Colors.black,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: '',
                backgroundColor: Colors.black,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_camera_back_outlined),
                label: '',
                backgroundColor: Colors.white,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '',
                backgroundColor: Colors.black,

              ),


            ],

            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,



          ));
  }
}
