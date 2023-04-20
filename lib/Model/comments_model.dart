


class CommentsModel{
  final String postId;
  final String userId;
  final String username;
  final String avatarUrl;
  final String text;
  final DateTime timestamp;

  CommentsModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.text,
    required this.timestamp,
  });


}