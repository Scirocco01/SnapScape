import 'package:ehisaab_2/App/injectors.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/profile_view_model.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute(
      {Key? key,
      required this.setupPageRoute,
      required this.userName,
      required this.profileUrl})
      : super(key: key);
  final String setupPageRoute;
  final String userName;
  final String profileUrl;

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
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
      case "dashboard/profile":
        page = ProfilePage(
          profileUrl: widget.profileUrl,
          userName: widget.userName,
        );
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

class ProfilePage extends StatefulWidget {
  final String profileUrl;
  final String userName;

  const ProfilePage(
      {super.key, required this.profileUrl, required this.userName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final ProfileViewModel viewModel = injector<ProfileViewModel>();

  List<String> postList = [];

  _getListPostImages() async {
    List<String> list = [];
    list = await viewModel.getImageUrlsByUserId('', true);
    setState(() {
      postList = list;
    });
  }
  @override
  void initState() {
    super.initState();
    _getListPostImages();

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => viewModel,
        child: Consumer<ProfileViewModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: Text(
                      widget.userName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        color: Colors.black,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await model.signOut();
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'Assets/sign-out-left-2.svg',
                                                    width: 34,
                                                    height: 34,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  PrimaryText(text: 'signOut'),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'Assets/setting.svg',
                                                  width: 34,
                                                  height: 34,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                PrimaryText(
                                                  text: 'Setting',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  body: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(height: 20),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(widget.profileUrl),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.userName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Bio info goes here',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: const [
                                    Text('Posts',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('120'),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Text('Followers',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('250'),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Text('Following',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('200'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.9,
                                    30),
                              ),
                              child: const Text('Edit Profile'),
                            ),
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
                            return postList.isNotEmpty?Container(
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      postList[index]),
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
                          childCount:postList.isEmpty? 9:postList.length,
                        ),
                      ),
                    ],
                  ),
                )));
  }
}

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key, required this.profileUrl, required this.userName}) : super(key: key);
//   final String profileUrl;
//   final String userName;
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             const Icon(Icons.lock_outline,color: Colors.black,),
//              PrimaryText(text: widget.userName,fontWeight: FontWeight.w500,),
//             const Expanded(
//               child: SizedBox(),
//             ),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.add_box,
//                   size: 30,
//                   color: Colors.grey,
//                 )),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.settings,
//                   size: 30,
//                   color: Colors.grey,
//                 )),
//
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 18.0,top: 18,right: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children:  [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundImage: widget.profileUrl == ''?
//                       const NetworkImage('https://e1.pxfuel.com/desktop-wallpaper/270/669/desktop-wallpaper-blue-fade-gradient-by-hk3ton-color-fade-thumbnail.jpg')
//                           :
//                           NetworkImage(widget.profileUrl)
//
//                     ),
//                     const SizedBox(height: 10,),
//
//                      PrimaryText(text: widget.userName,size: 16,fontWeight: FontWeight.w500,),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     PrimaryText(text: '6',fontWeight: FontWeight.bold,),
//                     PrimaryText(text: 'Posts')
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     PrimaryText(text: '160',fontWeight: FontWeight.bold,),
//                     PrimaryText(text: 'Followers')
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     PrimaryText(text: '157',fontWeight: FontWeight.bold,),
//                     PrimaryText(text: 'Following')
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
