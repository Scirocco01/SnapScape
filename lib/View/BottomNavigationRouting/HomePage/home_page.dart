import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehisaab_2/App/injectors.dart';
import 'package:ehisaab_2/Config/size_config.dart';
import 'package:ehisaab_2/Model/feed_data_model.dart';
import 'package:ehisaab_2/View/Components/comments_screen/comments_screen.dart';
import 'package:ehisaab_2/ViewModel/home_view_model.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'messaging_page.dart';

class HomePageRoute extends StatefulWidget {
  const HomePageRoute({
    Key? key,
    required this.setupPageRoute, required this.profileUrl, required this.userName,
  }) : super(key: key);

  final String setupPageRoute;
  final String profileUrl;
  final String userName;

  @override
  State<HomePageRoute> createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
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
      case "dashboard/home":
        page =  HomePage(profileUrl: widget.profileUrl, userName: widget.userName,);
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.profileUrl, required this.userName}) : super(key: key);
  final String profileUrl;
  final String userName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  final HomeViewModel viewModel = injector<HomeViewModel>();

  List<FeedDataModel> _feedDataList = [];

  Future<void> fetchAndDisplayPosts() async {
    print('function _feedDataList');
    _feedDataList = await viewModel.fetchFeedData();
    print('function after _feedDataList');
  }

  List<Story> myStories = [
    const Story(
        storyUrl:
            'https://thumbs.dreamstime.com/z/random-click-squirrel-wire-random-picture-cute-squirrel-219506797.jpg',
        userName: 'Ehtisham'),
    const Story(
        storyUrl:
            'https://edit.org/images/cat/instagram-stories-big-2019101613.jpg',
        userName: 'belluicha')
  ];

  List<Widget> feedWidgetList = [];

  _addDataToFeeDList() {
    for (int i = 0; i < _feedDataList.length; i++) {
      feedWidgetList.add(Feed(feed: _feedDataList[i],
        incrementLike: () {
        viewModel.incrementLikePost(_feedDataList[i].postId, _feedDataList[i].userId);
        }, model: viewModel, decrementLike: (){
            viewModel.decrementLikePost(_feedDataList[i].postId, _feedDataList[i].userId);
          })
      );
      print('this is should be the feed widget added to the List ${_feedDataList[i].name}');
    }
  }

  bool _isLoading = false;

  @override
  initState() {
    print('in home page this is the userName ${widget.userName}, and this is the userProfile pic ${widget.profileUrl}');
    setState(() {
      _isLoading = true;
    });
    super.initState();

    getAllDoc();
    fetchAndDisplayPosts().then((value) {
      setState(() {
        _addDataToFeeDList();
        _isLoading = false;

        print('feed widget added');
      });
    });
  }

  // Future<void> getProfilePhotoAndName() async {
  //   await viewModel.getProfilePhotoUrl();
  // }

  getAllDoc() async {
    await viewModel.getAllDocumentIds(viewModel.user!.uid);
    await viewModel.getMessageReceivers(viewModel.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
            builder: (context, model, child) => PageView(
                  controller: _pageController,
                  children: [
                    Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Instagram',
                                style: GoogleFonts.pacifico(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Transform.rotate(
                                angle: -30 * 3.1415926535 / 180,
                                child: IconButton(
                                    onPressed: () {
                                      if (_pageController.hasClients) {
                                        _pageController.animateToPage(1,
                                            duration: const Duration(
                                                milliseconds: 600),
                                            curve: Curves.decelerate);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      body: Padding(
                        padding:
                            const EdgeInsets.only(top: 4.0, left: 0, right: 0),
                        child: SingleChildScrollView(
                            child: !_isLoading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 35,
                                                        backgroundImage: widget
                                                                    .profileUrl !=
                                                                ""
                                                            ? NetworkImage(widget
                                                                .profileUrl)
                                                            : const NetworkImage(
                                                                'https://i.scdn.co/image/ab6761610000e5ebce202eea14763b8b7696936e')),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.blue,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white)),
                                                        child: const Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4.0),
                                                  child: PrimaryText(
                                                    text: 'Your Story',
                                                    size: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 100,
                                              width: SizeConfig.screenWidth! *
                                                  0.78,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: myStories.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Story(
                                                        storyUrl:
                                                            myStories[index]
                                                                .storyUrl,
                                                        userName:
                                                            myStories[index]
                                                                .userName);
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),

                                      Wrap(
                                        spacing:
                                            8.0, // space between adjacent widgets
                                        runSpacing:
                                            50.0, // space between lines of widgets
                                        children: feedWidgetList,
                                      )
                                      // Container(
                                      //
                                      //     height: 700,
                                      //     width: 500,
                                      //     child:
                                      // ListView.builder(
                                      //   itemCount: _feedDataList.length,
                                      //     itemBuilder: (context,index){
                                      //       return Feed(feed: _feedDataList[index]);
                                      //     }))
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                    ),
                    MessagingPage(
                      pageController: _pageController,
                      model: model,
                      profileUrl: widget.profileUrl, userName: widget.userName,
                    )
                  ],
                )));
  }
}

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    required this.feed, required this.incrementLike, required this.model, required this.decrementLike,
  }) : super(key: key);
  final FeedDataModel feed;
  final Function incrementLike;
  final Function decrementLike;
  final HomeViewModel model;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final ValueNotifier<bool> _isLiked = ValueNotifier<bool>(false);
  bool _showHeart = false;
  int likes = 0;

  void _toggleHeart() {
    setState(() {
      _showHeart = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _showHeart = false;
      });
    });
  }

  checkIfAlreadyLikedByUser()async{
    bool likedByUser = false;
    likedByUser = await widget.model.checkForLikedBy(widget.feed.postId, widget.feed.userId);
    setState((){
      _isLiked.value = likedByUser;
    });
  }
  String currentUserName = '';
  String currentUserProfileUrl = '';

  _getCurrentUserInfo() async {
   final List<String> list = await widget.model.getCurrentUserDat();
   currentUserName = list[0];
   currentUserProfileUrl = list[1];
  }

  @override
  void initState() {

    super.initState();
    checkIfAlreadyLikedByUser();
    likes = widget.feed.likes;
    setState(() {
      _getCurrentUserInfo();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 15,
                    backgroundImage: NetworkImage(widget.feed.profileUrl),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.02,
                  ),
                  PrimaryText(
                    text: '${widget.feed.name} ',
                    size: 16,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _isLiked.value = !_isLiked.value;
                  if(_isLiked.value){
                    likes += 1;
                    _toggleHeart();
                    widget.incrementLike();
                  }
                  else{
                    likes -= 1;
                    widget.decrementLike();
                  }

                });
              },
              child: SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.60,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: SizeConfig.screenHeight! * 0.60,
                      color: Colors.black, // or another background color
                    ),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.feed.postUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                    if (_showHeart)
                      Center(
                        child: AnimatedOpacity(
                          opacity: _showHeart ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(
                            Icons.favorite,
                            size: 80,
                            color: Colors.red,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Icon(
                    _isLiked.value
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: 28,
                    color: _isLiked.value ? Colors.red : Colors.black,
                  ),
                  // PrimaryText(text: '${widget.likes}',),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              CommentsScreen(feedData: widget.feed,
                                profileUrl: currentUserProfileUrl,
                                name:currentUserName,),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                      ),
                      child: SvgPicture.asset(
                        'Assets/comment_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                    child: SvgPicture.asset(
                      'Assets/instagram-share-icon.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  // PrimaryText(text: '${widget.comments}'),

                  const Expanded(
                    child: SizedBox(),
                  ),
                  SvgPicture.asset(
                    'Assets/instagram-save-icon.svg',
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 4),
              child: PrimaryText(
                text: '$likes likes',
                size: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 2),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: widget.feed.nickName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ' ${widget.feed.caption}',
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: PrimaryText(
                text: '${widget.feed.timeStamp} minutes ago',
                size: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}

class Story extends StatefulWidget {
  const Story({Key? key, required this.storyUrl, required this.userName})
      : super(key: key);
  final String storyUrl;
  final String userName;

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Color(0xFFd3677c))),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(widget.storyUrl),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: PrimaryText(
              text: widget.userName,
              size: 12,
            ),
          )
        ],
      ),
    );
  }
}
