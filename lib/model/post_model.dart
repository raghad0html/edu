class Comment {
  final String id;
  final String userName;
  final String text;

  Comment({
    required this.id,
    required this.userName,
    required this.text,
  });
}

class Post {
  final String id;
  final String authorName;
  final String category;
  final String content;
  int likesCount;
  bool isLiked;
  List<Comment> comments;

  Post({
    required this.id,
    required this.authorName,
    required this.category,
    required this.content,
    this.likesCount = 0,
    this.isLiked = false,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}