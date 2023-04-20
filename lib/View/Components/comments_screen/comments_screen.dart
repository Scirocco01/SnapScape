import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/Model/feed_data_model.dart';
import 'package:ehisaab_2/ViewModel/comments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../App/injectors.dart';
import '../../../Model/comments_model.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    Key? key,
    required this.feedData,
    required this.profileUrl,
    required this.name,
  }) : super(key: key);
  final FeedDataModel feedData;
  final String profileUrl;
  final String name;

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final CommentsViewModel viewModel = injector<CommentsViewModel>();

  List<CommentsModel> _comments = [];
  String recentComment = '';

  _getAllComments() async {
    List<CommentsModel> list = [];
    list= await viewModel.getCommentsForPost(widget.feedData.postId);
    print('these are the comments ${list}');
    setState(() {
      _comments = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllComments();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentsViewModel>(
        create: (context) => viewModel,
        child: Consumer<CommentsViewModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    elevation: 0.5,
                    iconTheme: IconThemeData(
                      color: Colors.black
                    ),
                    backgroundColor: Colors.white,
                    title: PrimaryText(text: 'Comments',color: Colors.black,)

                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                foregroundImage: NetworkImage(
                                  widget.profileUrl,
                                ),
                              ),
                              title:  Text(_comments[index].username),
                              subtitle: Text(_comments[index].text),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2,right: 4,left: 4),
                        decoration: const BoxDecoration(
                            borderRadius:BorderRadius.all(Radius.circular(24)),
                            
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple.shade100,
                                  width: 2
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(32))
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.profileUrl),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add a comment.. .. .'
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_textEditingController.text.isNotEmpty) {
                                    setState(() {
                                      _comments.add(CommentsModel(
                                          postId: widget.feedData.postId,
                                          userId: widget.feedData.userId,
                                          username: widget.name,
                                          avatarUrl: widget.profileUrl,
                                          text: _textEditingController.text,
                                          timestamp: DateTime.now()));
                                      recentComment = _textEditingController.text;
                                      _textEditingController.clear();

                                    });
                                    model.saveComment(CommentsModel(
                                        postId: widget.feedData.postId,
                                        userId: widget.feedData.userId,
                                        username: widget.name,
                                        avatarUrl: widget.profileUrl,
                                        text: recentComment,
                                        timestamp: DateTime.now()));
                                  }
                                },
                                child: PrimaryText(
                                    text: 'Post',
                                    color:
                                        _textEditingController.text.isNotEmpty
                                            ? Colors.blue
                                            : Colors.blueGrey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
