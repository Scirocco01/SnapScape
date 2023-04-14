import 'package:ehisaab_2/App/injectors.dart';
import 'package:ehisaab_2/Config/size_config.dart';
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
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

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
        page = const HomePage();
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
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  final HomeViewModel viewModel = injector<HomeViewModel>();


  @override
   initState() {

    super.initState();
    getProfilePhotoAndName();
    getAllDoc();
  }

  Future<void> getProfilePhotoAndName()async{
    await viewModel.getProfilePhotoUrl();
  }
  getAllDoc()async{
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
                          padding: const EdgeInsets.only(top: 8.0,right: 6),
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
                                            duration:
                                                const Duration(milliseconds: 600),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Stack(
                                          children: [
                                             CircleAvatar(
                                              radius: 35,
                                              backgroundImage: model.profilePhotoUrl != ""?NetworkImage(model.profilePhotoUrl):
                                                  const NetworkImage('https://i.scdn.co/image/ab6761610000e5ebce202eea14763b8b7696936e')
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue,
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: const Center(
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: PrimaryText(
                                            text: 'Your Story',
                                            size: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: SizeConfig.screenWidth! * 0.78,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: myStories.length,
                                          itemBuilder: (context, index) {
                                            return Story(
                                                storyUrl:
                                                    myStories[index].storyUrl,
                                                userName:
                                                    myStories[index].userName);
                                          }),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              Wrap(
                                spacing: 8.0, // space between adjacent widgets
                                runSpacing:
                                    50.0, // space between lines of widgets
                                children: myFeed,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    MessagingPage(
                      pageController: _pageController,
                      model: model,
                    )
                  ],
                )));
  }
}

class Feed extends StatefulWidget {
  const Feed(
      {Key? key,
      required this.name,
      required this.nickName,
      required this.avatarColor,
      required this.url,
      required this.likes,
      required this.comments,
      required this.tag,
      required this.timeStamp,
      required this.avatarUrl})
      : super(key: key);

  final String name;
  final String nickName;
  final Color avatarColor;
  final String url;
  final String avatarUrl;
  final int likes;
  final int comments;
  final String tag;
  final int timeStamp;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: widget.avatarColor,
                    radius: 15,
                    backgroundImage: NetworkImage(widget.avatarUrl),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.02,
                  ),
                  PrimaryText(
                    text: '${widget.name} ',
                    size: 16,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: SizeConfig.screenHeight! * 0.60,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.url), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_border_outlined,
                    size: 28,
                  ),
                  // PrimaryText(text: '${widget.likes}',),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                    ),
                    child: SvgPicture.asset(
                      'Assets/comment_icon.svg',
                      width: 24,
                      height: 24,
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
                text: '${widget.likes} likes',
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
                      text: widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ' ${widget.tag}',
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
                text: '${widget.timeStamp} minutes ago',
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
