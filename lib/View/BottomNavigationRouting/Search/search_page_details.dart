


import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/Model/feed_data_model.dart';
import 'package:ehisaab_2/Model/user_profile_model.dart';
import 'package:ehisaab_2/View/BottomNavigationRouting/Profile/persons_profile_page.dart';
import 'package:ehisaab_2/ViewModel/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Config/size_config.dart';

class SearchPageExplore extends StatefulWidget {
  const SearchPageExplore({Key? key, required this.url, required this.feed, required this.model, required this.list}) : super(key: key);

  final String url;
  final FeedDataModel feed;
  final SearchViewModel model;
  final List<int> list;


  @override
  State<SearchPageExplore> createState() => _SearchPageExploreState();
}

class _SearchPageExploreState extends State<SearchPageExplore> {
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

  late UserProfileModel userProfileModel;
  List<int> postCount = [];
  _getPostCount()async{
    final List<int> _postCount = await widget.model.getPostCount(widget.feed.userId);
    setState(() {
      postCount = _postCount;

    });
    print('this is the List postcount $postCount');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPostCount();
    userProfileModel = UserProfileModel(
        userId: widget.feed.userId,
        userName: widget.feed.nickName,
        profileUrl: widget.feed.profileUrl,
        postsCount: widget.list[0],
        followersCount: widget.list[0],
        followingCount: widget.list[0]);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            },
                icon: const Icon(Icons.arrow_back,color: Colors.black,
                )),
            const PrimaryText(text: 'Explore')
          ],
        ),
      ),
      body:SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) =>
                                PersonsProfilePage(userProfileModel: userProfileModel),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 15,
                        backgroundImage: NetworkImage(widget.feed.profileUrl),
                      ),
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
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
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
                  text: '${likes} likes',
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
          ))
      //
    );
  }
}

// Hero(
//   tag: widget.url,
//   child: FadeInImage(
//     placeholder: const AssetImage('Assets/blurred_placeholder.webp'),
//     image: NetworkImage(widget.url),
//     fit: BoxFit.fill,
//   )
//
// ),