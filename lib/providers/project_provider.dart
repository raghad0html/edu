import 'package:flutter/material.dart';
import 'package:test/model/project_simulation_model.dart';

class ProjectProvider with ChangeNotifier {
  ProjectSimulationResult? _currentSimulation;
  bool _isProcessing = false;

  ProjectSimulationResult? get currentSimulation => _currentSimulation;
  bool get isProcessing => _isProcessing;

  // محرك الحسابات الذكي للمشاريع
  void calculateProjectRequirements({
    required String projectType,
    required double area,
    required int users,
  }) async {
    _isProcessing = true;
    notifyListeners();

    // محاكاة تأخير زمني بسيط لإعطاء هيبة للحسابات التقنية الذكية
    await Future.delayed(Duration(seconds: 2));

    List<BomItem> calculatedBom = [];
    List<String> installationSteps = [];
    String topologyAsset = 'assets/topologies/default.png';

    if (projectType == "مقهى إنترنت") {
      // 1. حساب الراوتر المناسب بناءً على عدد المستخدمين
      if (users > 20) {
        calculatedBom.add(BomItem(
          name: "راوتر Multi-WAN Load Balance (مثل Cisco أو Mikrotik)",
          quantity: 1,
          reason: "لدمج خطين إنترنت وتوزيع الحمل لضمان عدم انقطاع الخدمة عن الزبائن.",
        ));
      } else {
        calculatedBom.add(BomItem(
          name: "راوتر ذكي متقدم (Gigabit Router)",
          quantity: 1,
          reason: "كافٍ للتعامل مع حركة البيانات لعدد مستخدمين محدود.",
        ));
      }

      // 2. حساب عدد أجهزة الـ Access Points بناءً على المساحة
      // قاعدة تقنية: كل 100 متر مربع تحتاج AP واحدة تغطية ممتازة بدون جدران عازلة
      int apCount = (area / 100).ceil();
      if (apCount < 1) apCount = 1;
      
      calculatedBom.add(BomItem(
        name: "Access Point Dual-Band (2.4GHz / 5GHz)",
        quantity: apCount,
        reason: "تغطية مساحة $area متر مربع وتوزيع الترددات لمنع تداخل الإشارة.",
      ));

      // 3. حساب السويتش والكبلات
      calculatedBom.add(BomItem(
        name: "سويتش بـ 24 منفذ يدعم PoE",
        quantity: 1,
        reason: "لتوصيل الحواسيب الثابتة وتغذية الـ Access Points بالطاقة عبر كبل الشبكة مباشرة.",
      ));
      
      calculatedBom.add(BomItem(
        name: "صندوق كبلات Cat6 UTP (305 متر)",
        quantity: users > 15 ? 2 : 1,
        reason: "لتوصيل كافة النقاط الثابتة ومقاهي الألعاب بسرعة تصل لـ 1Gbps.",
      ));

      // المخطط البياني المخصص بناءً على الحجم
      topologyAsset = users > 20 ? 'assets/topologies/cyber_cafe_large.png' : 'assets/topologies/cyber_cafe_small.png';

      // خطوات التركيب الاحترافية مرتبة هندسياً
      installationSteps = [
        "١. تمديد كبلات Cat6 من موقع السويتش المركزي إلى نقاط الحواسيب والـ APs.",
        "٢. تثبيت الـ Access Points في الأسقف بشكل متناظر وتوصيلها بالسويتش (PoE).",
        "٣. إعداد الراوتر الرئيسي وتفعيل الـ DHCP Server بمدى تفرع (Subnet) يغطي الزبائن.",
        "٤. ضبط حماية الشبكة (VLAN Isolation) لعزل شبكة الإدارة عن شبكة الزبائن العامة لحمايتها.",
      ];
    }

    _currentSimulation = ProjectSimulationResult(
      projectType: projectType,
      bomList: calculatedBom,
      topologyImageUrl: topologyAsset,
      steps: installationSteps,
    );

    _isProcessing = false;
    notifyListeners();
  }

  void resetSimulation() {
    _currentSimulation = null;
    notifyListeners();
  }
}