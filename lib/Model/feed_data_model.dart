



import 'package:flutter/cupertino.dart';

class FeedDataModel{
   String name;
   String nickName;
   String profileUrl;
   String postUrl;
   int likes;
   int comments;
   String caption;
   int timeStamp;
   String postId;
   String userId;


   FeedDataModel({
      required this.name,
      required this.nickName,
      required this.profileUrl,
      required this.postUrl,
      required this.likes,
   required this.comments,
      required this.caption,
      required this.timeStamp,
      required this.postId,
      required this.userId,

   });
}