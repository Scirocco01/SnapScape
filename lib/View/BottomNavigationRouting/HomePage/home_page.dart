


import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Feed> myFeed = [
    const Feed(name: 'sanan', nickName: 'sin', avatarColor: Colors.green, url: 'https://media.timeout.com/images/100004361/750/562/image.jpg',
        avatarUrl: 'https://cdn.pixabay.com/photo/2016/11/22/21/42/woman-1850703__340.jpg',
        likes: 224, comments: 55, tag: 'hi this is a tag repeat reset ', timeStamp: 10),
    const Feed(name: 'faraz', nickName: 'sin', avatarColor: Colors.green, url: 'https://pixlr.com/images/index/remove-bg.webp',
        avatarUrl: 'https://wallpapers.com/images/hd/cool-profile-picture-ld8f4n1qemczkrig.jpg',
        likes: 224, comments: 59, tag: 'hi this is a tag repeat reset ', timeStamp: 10),
    const Feed(name: 'Hush', nickName: 'sin', avatarColor: Colors.green, url: 'https://hips.hearstapps.com/hmg-prod/images/alpe-di-siusi-sunrise-with-sassolungo-or-langkofel-royalty-free-image-1623254127.jpg',
        avatarUrl: 'https://1fid.com/wp-content/uploads/2022/07/aesthetic-profile-picture-2-1024x1024.jpg',
        likes: 224, comments: 4, tag: 'hi this is a tag repeat reset ', timeStamp: 10),
  ];

  widgetBuilder(){
    for(int i = 0;i<myFeed.length;i++){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0,left: 0,right: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const CircleAvatar(
                    backgroundColor: Colors.orange,
                    backgroundImage: NetworkImage('https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg'),
                  ),
                  const Expanded(child: SizedBox()),
                  const PrimaryText(text: 'TodoKlickker',fontWeight: FontWeight.w600,),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    icon:Icon(Icons.ac_unit,color: Colors.amber[800]), onPressed: () {  },),
                  const SizedBox(width: 10,),
                   IconButton(
                     icon:Icon(Icons.mail,color: Colors.black),
                     onPressed: () {  },),
                ],
              ),
              SizedBox(height: 20,),


              Wrap(
                spacing: 8.0, // space between adjacent widgets
                runSpacing: 50.0, // space between lines of widgets
                children: myFeed,
              )




          ],
          ),
        ),
      ),
    );
  }
}


class Feed extends StatefulWidget {
  const Feed({Key? key,
    required this.name,
    required this.nickName,
    required this.avatarColor,
    required this.url,
    required this.likes,
    required this.comments,
    required this.tag,
    required this.timeStamp, required this.avatarUrl}) : super(key: key);

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
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: widget.avatarColor,
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
                PrimaryText(text: '${widget.name} \n @${widget.nickName}'),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_horiz))

              ],
            ),
          ),
          Container(
            width:double.infinity,
            height: 250,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: NetworkImage(widget.url),
                      fit: BoxFit.cover
                  )
              ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              children: [
                const Icon(Icons.favorite_border_outlined),
                PrimaryText(text: '${widget.likes}'),
                const Icon(Icons.mode_comment_outlined),
                PrimaryText(text: '${widget.comments}'),
                const Expanded(child: SizedBox(),),
                const Icon(Icons.share),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4),
            child: PrimaryText(text: widget.tag,size: 12,),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage('https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg'),
                ),
                 PrimaryText(text: 'add a comment',size: 16,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: PrimaryText(text: '${widget.timeStamp} minutes ago',size: 12,color: Colors.grey,),
          ),
        ],
        
      )
    );
  }
}
