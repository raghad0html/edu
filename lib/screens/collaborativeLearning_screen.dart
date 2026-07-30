import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/forum_provider.dart';

class CollaborativeLearning extends StatefulWidget {
  final String currentUserName;

  const CollaborativeLearning({
    Key? key,
    this.currentUserName = 'طالب تقني', // قيمة افتراضية إذا لم يتم التمرير
  }) : super(key: key);

  @override
  State<CollaborativeLearning> createState() => _CollaborativeLearningState();
}

class _CollaborativeLearningState extends State<CollaborativeLearning> {
  final List<String> categories = ['الكل', 'ألياف ضوئية', 'إعدادات الراوتر', 'شبكات لاسلكية'];
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  // نافذة إضافة منشور جديد
  void _showAddPostDialog(BuildContext context, String currentUserName) {
    String selectedCat = 'ألياف ضوئية';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1A237E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "رفع سيناريو تقني جديد",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: selectedCat,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A237E),
                    underline: const SizedBox(),
                    items: categories.where((c) => c != 'الكل').map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() => selectedCat = val);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _postController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "اشرح السيناريو التقني أو المشكلة هنا...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_postController.text.trim().isNotEmpty) {
                      Provider.of<ForumProvider>(context, listen: false)
                          .addPost(_postController.text.trim(), selectedCat, currentUserName);
                      _postController.clear();
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("نشر في المنتدى"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // نافذة عرض وإضافة التعليقات
  void _showCommentsBottomSheet(BuildContext context, dynamic post, ForumProvider provider, String currentUserName) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.6,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xFF0D1B2A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
              ),
              const Text("التعليقات والمناقشات", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(color: Colors.white24, height: 25),
              Expanded(
                child: post.comments.isEmpty
                    ? const Center(child: Text("لا توجد تعليقات بعد. كن أول المعلقين!", style: TextStyle(color: Colors.white54)))
                    : ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          final comment = post.comments[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(Icons.person, size: 18, color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(comment.userName, style: const TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold, fontSize: 13)),
                                      const SizedBox(height: 3),
                                      Text(comment.text, style: const TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "أكتب تعليقك هنا...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.lightBlueAccent),
                    onPressed: () {
                      if (commentController.text.trim().isNotEmpty) {
                        provider.addComment(post.id, commentController.text.trim(), currentUserName);
                        commentController.clear();
                        Navigator.pop(ctx);
                        _showCommentsBottomSheet(context, post, provider, currentUserName);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final forumProvider = Provider.of<ForumProvider>(context);
    
    // استخدام اسم المستخدم الممرر للشاشة مباشرة
    final String currentUserName = widget.currentUserName;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000428), Color(0xFF004e92)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildCategoryBar(forumProvider),
              const SizedBox(height: 10),
              Expanded(
                child: forumProvider.filteredPosts.isEmpty
                    ? const Center(child: Text("لا توجد منشورات في هذا القسم", style: TextStyle(color: Colors.white54)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: forumProvider.filteredPosts.length,
                        itemBuilder: (ctx, i) {
                          final post = forumProvider.filteredPosts[i];
                          return Card(
                            color: Colors.white.withOpacity(0.08),
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: Icon(Icons.person, color: Colors.white),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(post.authorName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.star, color: Colors.amber, size: 12),
                                                    SizedBox(width: 2),
                                                    Text("خبير شبكات", style: TextStyle(color: Colors.amber, fontSize: 10)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(post.category, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(post.content, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
                                  const SizedBox(height: 15),
                                  const Divider(color: Colors.white12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () => forumProvider.toggleLike(post.id),
                                        child: Row(
                                          children: [
                                            Icon(
                                              post.isLiked ? Icons.favorite : Icons.favorite_border,
                                              color: post.isLiked ? Colors.redAccent : Colors.white60,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text('${post.likesCount}', style: const TextStyle(color: Colors.white60)),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => _showCommentsBottomSheet(context, post, forumProvider, currentUserName),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.mode_comment_outlined, color: Colors.white60, size: 20),
                                            const SizedBox(width: 5),
                                            Text('${post.comments.length}', style: const TextStyle(color: Colors.white60)),
                                          ],
                                        ),
                                      ),
                                      const InkWell(
                                        child: Row(
                                          children: [
                                            Icon(Icons.share_outlined, color: Colors.white60, size: 20),
                                            SizedBox(width: 5),
                                            Text('مشاركة', style: TextStyle(color: Colors.white60)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPostDialog(context, currentUserName),
        label: const Text("رفع سيناريو تقني"),
        icon: const Icon(Icons.upload_file),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Collaborative Hub", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("مجتمع الطلاب التقني والتفاعلي", style: TextStyle(color: Colors.white70)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20)),
            child: const Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text("120 XP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(ForumProvider provider) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => provider.setCategory(categories[i]),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: provider.selectedCategory == categories[i] ? Colors.blueAccent : Colors.white10,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            alignment: Alignment.center,
            child: Text(categories[i], style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}