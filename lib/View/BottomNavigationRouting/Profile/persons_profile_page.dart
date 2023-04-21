


import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';

import '../../../Model/user_profile_model.dart';

class PersonsProfilePage extends StatefulWidget {
  const PersonsProfilePage({Key? key, required this.userProfileModel}) : super(key: key);
  final UserProfileModel userProfileModel;

  @override
  State<PersonsProfilePage> createState() => _PersonsProfilePageState();
}

class _PersonsProfilePageState extends State<PersonsProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: (){},
                icon: const Icon(Icons.arrow_back,color: Colors.black,)),
            PrimaryText(text: widget.userProfileModel.userName),
            Expanded(child: SizedBox()),
            IconButton(onPressed: (){},
                icon: Icon(Icons.more_vert,color: Colors.black,))
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
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(widget.userProfileModel.profileUrl),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.userProfileModel.userName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                      Column(
                        children: [
                          const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.userProfileModel.postsCount.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Followers', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.userProfileModel.followersCount.toString()),
                        ],
                      ),
                      Column(
                        children:  [
                         const Text('Following', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.userProfileModel.followingCount.toString()),
                        ],
                      ),
                    ],
                  ),
                ),

                // row for buttons follow and unfollow
                Row(
                  children:[
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.blue,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                      ),
                      child: const Text('Follow'),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white,
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                      ),
                      child: const Text('Message'),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                const Divider(height: 30),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://avatarfiles.alphacoders.com/337/337077.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              childCount: 9,
            ),
          ),
        ],
      ),
    );
  }
}
