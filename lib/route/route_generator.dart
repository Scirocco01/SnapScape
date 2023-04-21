


import 'package:ehisaab_2/View/BottomNavigationRouting/Search/search_page.dart';
import 'package:flutter/material.dart';


class RouteGenerator{
  static Route<dynamic> generatedRoute(RouteSettings settings){

    switch(settings.name){
      // case '/':
      //   return MaterialPageRoute(builder:(_) => const HomePage());

      case '/Date_time_picker':
        return MaterialPageRoute(builder: (_) => const SearchPage());

      default:
        return error_route();
    }

  }
  static Route<dynamic> error_route(){
    return MaterialPageRoute(builder: (_){
      return Expanded(
          child:Container(
            color: Colors.red,
            child: const Center(
              child: Text('No route Found'),
            ),
          ) );
    });
  }
}