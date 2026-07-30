class Post {
  final String id;
  final String author;
  final String content;
  final String category; // التخصص: ألياف، راوتر، شبكات
  final String? imageUrl; // رابط صورة السيناريو التقني
  final DateTime timestamp;
  int likes;
  int expertPoints; // نقاط الخبرة الممنوحة للمنشور

  Post({
    required this.id,
    required this.author,
    required this.content,
    required this.category,
    this.imageUrl,
    required this.timestamp,
    this.likes = 0,
    this.expertPoints = 0,
  });
}