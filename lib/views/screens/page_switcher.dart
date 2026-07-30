import 'package:flutter/material.dart';
import 'package:test/ar/googleAr.dart';
import 'package:test/constant/app_color.dart';
import 'package:test/screens/bot_screen.dart';
import 'package:test/screens/collaborativeLearning_screen.dart';
import 'package:test/screens/project_simulation_screen.dart';
import 'package:test/screens/voice_directory_screen.dart';
import 'package:test/views/screens/home_page.dart';
import 'package:test/views/screens/profile_page.dart';
import 'package:test/model/user_model.dart'; // تأكد من صحة مسار الموديل لديك

import '../../ar/RouterArRecognizerView.dart';

class PageSwitcher extends StatefulWidget {
  final UserModel? currentUser;

  const PageSwitcher({Key? key, this.currentUser}) : super(key: key);

  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  // قائمة أيقونات Flutter المدمجة (7 شاشات)
  final List<Map<String, IconData>> _navItems = [
    {'active': Icons.home, 'inactive': Icons.home_outlined},
    {'active': Icons.smart_toy, 'inactive': Icons.smart_toy_outlined},
    {'active': Icons.groups, 'inactive': Icons.groups_outlined},
    {'active': Icons.view_in_ar, 'inactive': Icons.view_in_ar_outlined}, // الزر الأوسط المميز (فهرس 3)
    {'active': Icons.keyboard_voice, 'inactive': Icons.keyboard_voice_outlined},
    {'active': Icons.laptop_chromebook, 'inactive': Icons.laptop_chromebook_outlined},
    {'active': Icons.person, 'inactive': Icons.person_outline},
  ];

  @override
  void initState() {
    super.initState();
    // تهيئة الشاشات مع استخراج اسم المستخدم من UserModel الممرر
    final String currentUserName = widget.currentUser?.fullName ?? 'طالب تقني';
    _pages = [
      HomePage(),
      BotScreen(),
      CollaborativeLearning(currentUserName: currentUserName),
      SimpleScannerScreen(),
      VoiceDirectoryScreen(),
      ProjectSimulationScreen(),
      ProfilePage(currentUser: widget.currentUser),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int centerIndex = 3; // RouterArRecognizerView

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColor.primarySoft, width: 2),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemWidth = constraints.maxWidth / _pages.length;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_pages.length, (index) {
                  bool isSelected = _selectedIndex == index;
                  bool isCenter = index == centerIndex;

                  IconData iconData = isSelected
                      ? _navItems[index]['active']!
                      : _navItems[index]['inactive']!;

                  // التبويبة الوسطى (AR View) بحجم أكبر وخلفية دائريّة بارزة
                  if (isCenter) {
                    return SizedBox(
                      width: itemWidth,
                      child: GestureDetector(
                        onTap: () => _onItemTapped(index),
                        child: Center(
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColor.primarySoft : Colors.blueAccent,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: Icon(
                              iconData,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // بقية التبويبات
                  return SizedBox(
                    width: itemWidth,
                    child: GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Center(
                        child: Icon(
                          iconData,
                          size: 22,
                          color: isSelected ? AppColor.primarySoft : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}