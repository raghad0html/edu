// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test/model/post.dart';

// import '../providers/forum_provider.dart';

// class PostCard extends StatelessWidget {
//   final Post post;
//   PostCard({required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               _buildBadge(post.expertPoints),
//               SizedBox(width: 10),
//               Text(post.author, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//               Spacer(),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
//                 child: Text(post.category, style: TextStyle(fontSize: 10, color: Colors.lightBlueAccent)),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(post.content, style: TextStyle(color: Colors.white, fontSize: 16)),
          
//           // عرض صورة السيناريو إذا وُجدت
//           if (post.imageUrl != null) 
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               height: 150,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(image: NetworkImage("https://via.placeholder.com/400x200"), fit: BoxFit.cover),
//               ),
//             ),

//           Divider(color: Colors.white10, height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton.icon(
//                 onPressed: () => Provider.of<ForumProvider>(context, listen: false).awardPoints(post.id),
//                 icon: Icon(Icons.star, color: Colors.amber, size: 18),
//                 label: Text("${post.expertPoints} XP", style: TextStyle(color: Colors.amber)),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.white10, elevation: 0),
//                 onPressed: () {}, 
//                 child: Text("تقييم السيناريو", style: TextStyle(fontSize: 12)),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBadge(int points) {
//     if (points > 40) return Icon(Icons.verified, color: Colors.blueAccent, size: 20);
//     return Icon(Icons.school, color: Colors.white38, size: 20);
//   }
// }