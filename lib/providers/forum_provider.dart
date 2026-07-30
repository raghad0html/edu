import 'package:flutter/material.dart';
import 'package:test/model/post_model.dart';


class ForumPost {
  final String id;
  final String content;
  final String category;
  final String authorName;
  bool isLiked; // تم إزالة final لتسمح بالتعديل
  int likesCount; // تم إزالة final لتسمح بالتعديل
  final List<ForumComment> comments;

  ForumPost({
    required this.id,
    required this.content,
    required this.category,
    required this.authorName,
    this.isLiked = false,
    this.likesCount = 0,
    required this.comments,
  });
}

class ForumComment {
  final String text;
  final String userName;

  ForumComment({required this.text, required this.userName});
}

class ForumProvider with ChangeNotifier {
  String _selectedCategory = 'الكل';
  final List<ForumPost> _posts = [];

  String get selectedCategory => _selectedCategory;

  List<ForumPost> get filteredPosts {
    if (_selectedCategory == 'الكل') return _posts;
    return _posts.where((p) => p.category == _selectedCategory).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // إضافة منشور جديد مع تمرير اسم المستخدم الحالي
  void addPost(String content, String category, String userName) {
    final newPost = ForumPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      category: category,
      authorName: userName.isNotEmpty ? userName : 'طالب تقني',
      comments: [],
    );
    _posts.insert(0, newPost);
    notifyListeners();
  }

  // إضافة تعليق جديد مع تمرير اسم المستخدم الحالي
  void addComment(String postId, String commentText, String userName) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].comments.add(
        ForumComment(
          text: commentText,
          userName: userName.isNotEmpty ? userName : 'طالب تقني',
        ),
      );
      notifyListeners();
    }
  }
  // دالة الإعجاب (تغطي الخطأ الأول)
  void toggleLike(String postId) {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index].isLiked = !_posts[index].isLiked;
      if (_posts[index].isLiked) {
        _posts[index].likesCount++;
      } else {
        _posts[index].likesCount--;
      }
      notifyListeners();
    }
  }



}