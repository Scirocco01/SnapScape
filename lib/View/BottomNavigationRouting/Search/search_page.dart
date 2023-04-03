import 'dart:math';

import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Search/search_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class SearchPageRoute extends StatefulWidget {
  const SearchPageRoute({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  State<SearchPageRoute> createState() => _SearchPageRouteState();
}

class _SearchPageRouteState extends State<SearchPageRoute> {
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
      case "dashboard/search":
        page = const SearchPage();
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

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                print('should naviagate tonext screen');

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SearchTab()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, right: 30, left: 30, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(67, 158, 158, 158)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10.0, top: 10, left: 10),
                    child: Row(children: const [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      PrimaryText(text: 'search'),
                    ]),
                  ),
                ),
              ),
            ),
            Expanded(
                child: GridView.custom(
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: [
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 2),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => Tile(index: index),
                    ))),
          ]),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;

  const Tile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rng = Random(index);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = rng.nextDouble() * 100 * 100;
    final url = '//source.unsplash.com/random/400x600';
    return Container(child: Center(child: PrimaryText(text: '$index',),),);
  }
}