


class UserProfileModel {
  final String userId;
  final String userName;
  final String profileUrl;
  final int postsCount;
  final int followersCount;
  final int followingCount;

  UserProfileModel({
    required this.userId,
    required this.userName,
    required this.profileUrl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

}