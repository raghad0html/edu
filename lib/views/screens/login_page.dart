
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:test/constant/app_color.dart';
import 'package:test/model/user_model.dart';
import 'package:test/views/screens/page_switcher.dart';
import 'package:test/views/screens/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final List<Map<String, String>> mockUsers = [
    {'email': 'admin@email.com', 'password': 'admin123', 'name': 'مدير النظام'},
    {'email': 'user@email.com', 'password': 'userpass', 'name': 'مستخدم تجريبي'},
    {'email': 'test@test.com', 'password': '123456', 'name': 'طالب تجريبي'},
  ];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    String inputContact = emailController.text.trim();
    String password = passwordController.text.trim();

    if (inputContact.isEmpty || password.isEmpty) {
      _showSnackBar('يرجى كتابة البريد/الهاتف وكلمة المرور', Colors.orange);
      return;
    }

    setState(() => isLoading = true);

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      bool isOffline = connectivityResult.contains(ConnectivityResult.none);

      if (isOffline) {
        _loginOffline(inputContact, password);
      } else {
        await _loginOnline(inputContact, password);
      }
    } catch (e) {
      debugPrint("Login General Error: $e");
      _showSnackBar('حدث خطأ أثناء تنفيذ الطلب', Colors.red);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _loginOnline(String contact, String password) async {
    final url = Uri.parse('https://codek-software.com/athar/login.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'contact': contact,
          'password': password,
        }),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['ok'] == true) {
          String token = data['token'] ?? '';
          
          // تحويل استجابة الـ JSON لكائن UserModel بشكل آمن
          UserModel user = UserModel.fromJson(data, token: token);

          _showSnackBar('تم تسجيل الدخول بنجاح!', Colors.green);
          _navigateToHome(user);
        } else {
          _showSnackBar('بيانات الدخول غير صحيحة', Colors.red);
        }
      } else {
        try {
          final data = jsonDecode(response.body);
          if (data['error'] == 'INVALID_CREDENTIALS') {
            _showSnackBar('اسم المستخدم أو كلمة المرور غير صحيحة', Colors.red);
          } else if (data['error'] == 'MISSING_FIELDS') {
            _showSnackBar('يرجى إكمال جميع الحقول المطلوبة', Colors.orange);
          } else {
            _showSnackBar('خطأ في السيرفر: ${response.statusCode}', Colors.red);
          }
        } catch (_) {
          _showSnackBar('فشل الاتصال بالسيرفر (${response.statusCode})', Colors.red);
        }
      }
    } catch (e) {
      debugPrint("Network Exception: $e");
      _showSnackBar('تعذر الاتصال بالسيرفر، جاري المحاولة محلياً...', Colors.amber);
      _loginOffline(contact, password);
    }
  }

  void _loginOffline(String contact, String password) {
    final matchedUser = mockUsers.firstWhere(
      (user) => user['email'] == contact && user['password'] == password,
      orElse: () => {},
    );

    if (matchedUser.isNotEmpty) {
      // إنشائ كائن UserModel ببيانات افتراضية للوضع المحلي
      UserModel offlineUser = UserModel(
        id: 0,
        fullName: matchedUser['name'] ?? 'مستخدم أوفلاين',
        age: 20,
        contact: matchedUser['email'] ?? contact,
        role: 'طالب',
        token: 'offline_token',
      );

      _showSnackBar('تم تسجيل الدخول بالوضع المحلي (Offline)', Colors.blue);
      _navigateToHome(offlineUser);
    } else {
      _showSnackBar('بيانات الدخول غير صحيحة (وضع أوفلاين)', Colors.red);
    }
  }

  void _navigateToHome(UserModel user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PageSwitcher(currentUser: user),
      ),
    );
  }

  void _showSnackBar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Sign in',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' Sign up',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 12),
            child: Text(
              'Welcome Back ! 😁',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'youremail@email.com / Contact',
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/Message.svg',
                  colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '**********',
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/Lock.svg',
                  colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primarySoft,
              filled: true,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : handleLogin,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                  )
                : const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'poppins',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}