import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Search/search_page_details.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Search/search_tab.dart';
import 'package:ehisaab_2/ViewModel/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:provider/provider.dart';

import '../../../App/injectors.dart';
import '../../../Config/size_config.dart';
import '../../../Model/feed_data_model.dart';

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
  final SearchViewModel viewModel = injector<SearchViewModel>();

  List<FeedDataModel> _feedDataList = [];

  Future<void> fetchAndDisplayPosts() async {
    await viewModel.fetchFeedData();
  }

  @override
  void initState() {
    super.initState();
    fetchAndDisplayPosts().then((value) {
      print(viewModel.feedDataList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
        create: (context) => viewModel,
        child: Consumer<SearchViewModel>(
            builder: (context, model, child) => Scaffold(
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchTab()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25, right: 30, left: 30, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      const Color.fromARGB(67, 158, 158, 158)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, top: 10, left: 10),
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
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: StaggeredGridView.countBuilder(
                              padding: const EdgeInsets.all(4),
                              crossAxisCount: 6,
                              itemCount: model.feedDataList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Hero(
                                  tag:model.feedDataList[index].postUrl ,
                                  child: GestureDetector(
                                  onTap: () async {
                                    final List<int> list = await model.getPostCount(model.feedDataList[index].userId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) =>
                                            SearchPageExplore(url: model.feedDataList[index].postUrl,

                                              feed: model.feedDataList[index], model: model, list: list,),
                                      ),
                                    );
                                  },
                                  child: Tile(
                                    index: index,
                                    data: model.feedDataList[index],
                                  ),
                                ),
                              ),
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.count(2, index.isEven ? 3 : 2),
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                            ),
                          ),
                        ),
                      ]),
                )));
  }
}

class Tile extends StatelessWidget {
  final int index;
  final FeedDataModel data;

  const Tile({Key? key, required this.index, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.screenHeight! * 0.60,
            color: Colors.black, // or another background color
          ),
          Center(
            child: CachedNetworkImage(
              imageUrl: data.postUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

// GridView.custom(
// gridDelegate: SliverQuiltedGridDelegate(
// crossAxisCount: 4,
// mainAxisSpacing: 4,
// crossAxisSpacing: 4,
// repeatPattern: QuiltedGridRepeatPattern.inverted,
// pattern: [
// QuiltedGridTile(2, 2),
// QuiltedGridTile(1, 1),
// QuiltedGridTile(1, 1),
// QuiltedGridTile(1, 2),
// ],
// ),
// childrenDelegate: SliverChildBuilderDelegate(
// (context, index) => Tile(index: index, data: _feedDataList[index],),
// ))
