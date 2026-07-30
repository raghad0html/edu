class UserModel {
  final int id;
  final String fullName;
  final int age;
  final String contact;
  final String role;
  final String? token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.age,
    required this.contact,
    required this.role,
    this.token,
  });

  // تحويل البيانات القادمة من API الـ PHP إلى Object
  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    final userData = json['user'] ?? json;
    return UserModel(
      id: userData['id'] is int ? userData['id'] : int.parse(userData['id'].toString()),
      fullName: userData['full_name'] ?? '',
      age: userData['age'] is int ? userData['age'] : int.parse(userData['age'].toString()),
      contact: userData['contact'] ?? '',
      role: userData['role'] ?? 'طالب',
      token: token,
    );
  }

  // تحويل البيانات إلى JSON لحفظها محلياً (مثلاً في SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'age': age,
      'contact': contact,
      'role': role,
      'token': token,
    };
  }
}