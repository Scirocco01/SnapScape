


import 'package:ehisaab_2/View/HomePage/home_page.dart';
import 'package:ehisaab_2/View/Search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/navigation_provider_view_model.dart';

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
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12,bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            iconSize: 30,
            showUnselectedLabels: false,

            backgroundColor: Colors.black,
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
                backgroundColor: Colors.black,

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



          ),
        ),
      ) ,
    );
  }
}
