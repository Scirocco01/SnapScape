import 'package:ehisaab_2/App/injectors.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/user_profile_model.dart';
import '../../../ViewModel/profile_view_model.dart';

class PersonsProfilePage extends StatefulWidget {
  const PersonsProfilePage(
      {Key? key, required this.userProfileModel, required this.userPostsUrl})
      : super(key: key);
  final UserProfileModel userProfileModel;
  final List<String> userPostsUrl;

  @override
  State<PersonsProfilePage> createState() => _PersonsProfilePageState();
}

class _PersonsProfilePageState extends State<PersonsProfilePage> {
  final ProfileViewModel viewModel = injector<ProfileViewModel>();

  double _textSize = 17;
  double numberSize = 20;

  bool _following = false;

  List<String> postsUrl = [];

  Future<void> _getPostsList()async {
    List<String> _postsList = await viewModel.getImageUrlsByUserId(widget.userProfileModel.userId,false);
    setState(() {
      postsUrl = _postsList;
    });
  }

  Future<void> _checkIfFollows()async {
    bool contains = false;
    contains = await viewModel.getFollowerIDs(widget.userProfileModel.userId);
    setState(() {
      _following = contains;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPostsList();
    _checkIfFollows();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => viewModel,
        child: Consumer<ProfileViewModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                        PrimaryText(text: widget.userProfileModel.userName),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                  body: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Stack(
                                        children: [
                                          // Gradient border
                                          ShaderMask(
                                            shaderCallback: (Rect bounds) {
                                              return LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors
                                                      .deepPurple, // dark purple
                                                  Colors
                                                      .purpleAccent, // light purple
                                                  Colors.deepPurple.shade200,
                                                ],
                                              ).createShader(bounds);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              width: 2 * (45 + 2),
                                              height: 2 * (45 + 2),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(60 + 2)),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 7),
                                              ),
                                            ),
                                          ),
                                          // CircleAvatar
                                          Positioned.fill(
                                            top: 2,
                                            left: 2,
                                            bottom: 2,
                                            right: 2,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.7),
                                                child: CircleAvatar(
                                                  radius: 45,
                                                  backgroundImage: NetworkImage(
                                                      widget.userProfileModel
                                                          .profileUrl),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        widget.userProfileModel.userName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    children: [
                                      PrimaryText(
                                        text: widget.userProfileModel.postsCount
                                            .toString(),
                                        size: numberSize,
                                      ),
                                      PrimaryText(
                                        text: 'Posts',
                                        fontWeight: FontWeight.w500,
                                        size: _textSize,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    children: [
                                      PrimaryText(
                                        text: widget
                                            .userProfileModel.followersCount
                                            .toString(),
                                        size: numberSize,
                                      ),
                                      PrimaryText(
                                        text: 'Followers',
                                        fontWeight: FontWeight.w500,
                                        size: _textSize,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    children: [
                                      PrimaryText(
                                        text: widget
                                            .userProfileModel.followingCount
                                            .toString(),
                                        size: numberSize,
                                      ),
                                      PrimaryText(
                                        text: 'Following',
                                        fontWeight: FontWeight.w500,
                                        size: _textSize,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // row for buttons follow and unfollow
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if(!_following) {
                                      model.updateFollowers(widget.userProfileModel.userId);
                                    }
                                    setState(() {
                                      _following = !_following;
                                    });
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      Size(MediaQuery.of(context).size.width * 0.4, 30),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all<Color>(_following?Colors.grey.shade200:Colors.blue),
                                    foregroundColor: MaterialStateProperty.all<Color>(_following?Colors.black:Colors.white),
                                  ),
                                  child:  PrimaryText(text: _following?'UnFollow':'Follow',size: 15,fontWeight: FontWeight.w500,),
                                ),
                                const SizedBox(width: 20,),

                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      Size(MediaQuery.of(context).size.width * 0.4, 30),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                  ),
                                  child:const PrimaryText(text: 'message',size: 15,fontWeight: FontWeight.w500,),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            const Divider(height: 30),
                          ],
                        ),
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return postsUrl.isNotEmpty?Container(
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      postsUrl[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ):
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.black,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                          },
                          childCount:postsUrl.isEmpty? 9:postsUrl.length,
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
