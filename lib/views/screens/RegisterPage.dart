import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:test/constant/app_color.dart';
import 'package:test/model/user_model.dart';

import 'package:test/views/screens/page_switcher.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = 'طالب'; // القيمة الافتراضية للـ Role
  bool isLoading = false;
  bool isObscure = true;

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    contactController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // معالجة عملية التسجيل
Future<void> handleRegister() async {
    String fullName = fullNameController.text.trim();
    String ageText = ageController.text.trim();
    String contact = contactController.text.trim();
    String password = passwordController.text.trim();

    if (fullName.isEmpty || ageText.isEmpty || contact.isEmpty || password.isEmpty) {
      _showSnackBar('جميع الحقول مطلوبة', Colors.orange);
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null || age < 4 || age > 120) {
      _showSnackBar('يرجى إدخال عمر صحيح بين 4 و 120', Colors.orange);
      return;
    }

    if (password.length < 6) {
      _showSnackBar('كلمة المرور يجب أن لا تقل عن 6 أحرف', Colors.orange);
      return;
    }

    setState(() => isLoading = true);

    try {
      // إرسال الطلب مباشر للسيرفر
      await _registerOnline(fullName, age, contact, password, selectedRole);
    } catch (e) {
      debugPrint('Error: $e');
      _showSnackBar('حدث خطأ في الاتصال بالشبكة', Colors.red);
    } finally {
      // إغلاق الـ Loading دائماً مهما حدث لضمان عدم استمراره
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _registerOnline(String fullName, int age, String contact, String password, String role) async {
    final url = Uri.parse('https://codek-software.com/athar/register.php');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'full_name': fullName,
        'age': age,
        'contact': contact,
        'password': password,
        'role': role,
      }),
    );

    debugPrint("Response Status: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data['ok'] == true) {
        UserModel userModel = UserModel.fromJson(data);
        _showSnackBar('تم إنشاء الحساب بنجاح!', Colors.green);
        _navigateToHome(userModel);
      } else {
        _handleServerError(data['error']);
      }
    } else {
      try {
        final data = jsonDecode(response.body);
        _handleServerError(data['error']);
      } catch (_) {
        _showSnackBar('فشل الاتصال بالخادم (${response.statusCode})', Colors.red);
      }
    }
  }

  void _handleServerError(String? errorCode) {
    String errorMsg = 'حدث خطأ في التسجيل';
    switch (errorCode) {
      case 'MISSING_FIELDS':
        errorMsg = 'يرجى إكمال الحقول المطلوبة';
        break;
      case 'INVALID_AGE':
        errorMsg = 'العمر غير مسموح به';
        break;
      case 'INVALID_ROLE':
        errorMsg = 'نوع الحساب غير صائب';
        break;
      case 'WEAK_PASSWORD':
        errorMsg = 'كلمة المرور ضعيفة جداً';
        break;
      case 'CONTACT_ALREADY_EXISTS':
        errorMsg = 'البريد أو رقم التواصل مستخدم بالفعل';
        break;
    }
    _showSnackBar(errorMsg, Colors.red);
  }
  // التسجيل في حالة عدم وجود إنترنت (Offline Mode)
  void _registerOffline(String fullName, int age, String contact, String role) {
    UserModel localUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      fullName: fullName,
      age: age,
      contact: contact,
      role: role,
    );

    _showSnackBar('تم إنشاء حساب محلي (أوفلاين)', Colors.blue);
    _navigateToHome(localUser);
  }

  void _navigateToHome(UserModel user) {
    // يمكنك تمرير موديل المستخدم إلى PageSwitcher أو حفظه داخل Provider
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => PageSwitcher()),
      (route) => false,
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
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
        title: Text(
          'Create Account',
          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'Join Us Today! 🚀',
            style: TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.w700,
              fontFamily: 'poppins',
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please enter your details to create an account.',
            style: TextStyle(color: AppColor.secondary.withOpacity(0.7), fontSize: 12),
          ),
          SizedBox(height: 24),

          // 1. Full Name Field
          _buildTextField(
            controller: fullNameController,
            hint: 'Full Name',
            iconPath: 'assets/icons/Profile.svg', // تأكدي من وجود الأيقونة أو استبدالها بـ Icon(Icons.person)
          ),
          SizedBox(height: 16),

          // 2. Age Field
          _buildTextField(
            controller: ageController,
            hint: 'Age (e.g. 22)',
            keyboardType: TextInputType.number,
            iconPath: 'assets/icons/Calendar.svg',
          ),
          SizedBox(height: 16),

          // 3. Contact Field (Email or Phone)
          _buildTextField(
            controller: contactController,
            hint: 'Email or Contact Number',
            iconPath: 'assets/icons/Message.svg',
          ),
          SizedBox(height: 16),

          // 4. Role Selection (طالب / مدير)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColor.primarySoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedRole,
                isExpanded: true,
                items: ['طالب', 'مدير'].map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role, style: TextStyle(color: AppColor.secondary, fontSize: 14)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedRole = val);
                },
              ),
            ),
          ),
          SizedBox(height: 16),

          // 5. Password Field
          TextField(
            controller: passwordController,
            obscureText: isObscure,
            decoration: InputDecoration(
              hintText: 'Password (min 6 characters)',
              prefixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/icons/Lock.svg',
                  colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.primary,
                ),
                onPressed: () => setState(() => isObscure = !isObscure),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
          SizedBox(height: 28),

          // Sign Up Button
          ElevatedButton(
            onPressed: isLoading ? null : handleRegister,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 18),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    'Sign up',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String iconPath,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
    );
  }
}