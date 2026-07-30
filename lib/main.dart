import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/project_provider.dart';
import 'package:test/providers/voice_directory_provider.dart';
import 'package:test/screens/bot_screen.dart';
import 'package:test/providers/bot_provider.dart'; // تأكد من استيراد البوت بروفايدر
import 'package:test/screens/project_simulation_screen.dart';
import 'package:test/views/screens/welcome_page.dart';
import 'providers/forum_provider.dart';
import 'screens/collaborativeLearning_screen.dart';

void main() {
  runApp(
    // استخدام MultiProvider لدمج أكثر من بروفايدر
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ForumProvider()),
        ChangeNotifierProvider(create: (_) => BotProvider()), // إضافة البوت بروفايدر هنا
        ChangeNotifierProvider(create: (_) => ProjectProvider()),        // إضافة البروفايدر الجديد هنا
        ChangeNotifierProvider(create: (_) => VoiceDirectoryProvider()), // إضافة البروفايدر الجديد هنا
      ],
      child: MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Forum',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Color(0xFF0D47A1),
//         scaffoldBackgroundColor: Color(0xFF000428),
//       ),
//       // الآن BotScreen ستجد الـ BotProvider بنجاح
//       home: ProjectSimulationScreen(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Forum',
      debugShowCheckedModeBanner: false,
      // دمج خصائص الثيم (تم اختيار الألوان والخلفية البيضاء لتناسب الـ WelcomePage)
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Nunito',
        primaryColor: Color(0xFF0D47A1),
      ),
      // الشاشة الرئيسية المطلوبة
      home: WelcomePage(),
    );
  }
}