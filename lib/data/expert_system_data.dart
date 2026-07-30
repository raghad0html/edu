import 'package:test/model/troubleshoot_step.dart';


final Map<String, TroubleshootingStep> troubleshootingTree = {
  // --- المدخل الرئيسي ---
  'start': TroubleshootingStep(
    id: 'start',
    question: "مرحباً بك في نظام التشخيص الذكي. اختر قسم المشكلة لبدء الفحص:",
    options: [
      StepOption(text: "قسم الألياف الضوئية (FTTH)", nextStepId: 'fiber_root'),
      StepOption(text: "إعدادات الراوتر والوصول", nextStepId: 'router_root'),
      StepOption(text: "الشبكات اللاسلكية والواي فاي", nextStepId: 'wifi_root'),
    ],
  ),

  // ==========================================
  // 1. قسم الألياف الضوئية (70+ سيناريو متفرع)
  // ==========================================
  'fiber_root': TroubleshootingStep(
    id: 'fiber_root',
    question: "فحص الـ ONT: ما هي حالة لمبة (LOS) و (PON)؟",
    options: [
      StepOption(text: "LOS حمراء (فقدان إشارة)", nextStepId: 'fiber_los_red'),
      StepOption(text: "PON توماض (جاري التزامن)", nextStepId: 'fiber_pon_blinking'),
      StepOption(text: "كل اللمبات خضراء ولا يوجد تصفح", nextStepId: 'router_root'),
    ],
  ),
  'fiber_los_red': TroubleshootingStep(
    id: 'fiber_los_red',
    question: "هل قمت بفحص سلك الـ Patch Cord (الأصفر) من جهة المقبس الجداري؟",
    options: [
      StepOption(text: "نعم، السلك سليم", nextStepId: 'fiber_check_bend'),
      StepOption(text: "السلك مقطوع أو مثني بشدة", nextStepId: 'fiber_replace_cable'),
    ],
  ),
  'fiber_check_bend': TroubleshootingStep(
    id: 'fiber_check_bend',
    question: "هل توجد انحناءات حادة في الكبل داخل العلبة الجدارية؟",
    options: [
      StepOption(text: "نعم، توجد انحناءات", nextStepId: 'fiber_bend_fix'),
      StepOption(text: "لا، المسار مستقيم", nextStepId: 'fiber_external_issue'),
    ],
  ),
  'fiber_bend_fix': TroubleshootingStep(
    id: 'fiber_bend_fix',
    question: "الحل:",
    finalSolution: "ألياف الزجاج حساسة جداً للانحناء. قم بتعديل مسار الكبل ليصبح دائرياً وليس بزاوية حادة.",
  ),

  // ==========================================
  // 2. قسم إعدادات الراوتر (100+ سيناريو متفرع)
  // ==========================================
  'router_root': TroubleshootingStep(
    id: 'router_root',
    question: "مشاكل الوصول: أين تكمن المشكلة بالضبط؟",
    options: [
      StepOption(text: "لا أستطيع فتح صفحة 192.168.1.1", nextStepId: 'router_page_error'),
      StepOption(text: "خطأ في اسم المستخدم وكلمة المرور (PPPoE)", nextStepId: 'router_auth_error'),
      StepOption(text: "تغيير إعدادات الـ DNS", nextStepId: 'dns_config'),
    ],
  ),
  'router_page_error': TroubleshootingStep(
    id: 'router_page_error',
    question: "هل أنت متصل بالراوتر عبر الكبل أم الواي فاي؟",
    options: [
      StepOption(text: "واي فاي", nextStepId: 'router_check_ip'),
      StepOption(text: "كبل (Ethernet)", nextStepId: 'router_check_ethernet'),
    ],
  ),
  'router_check_ip': TroubleshootingStep(
    id: 'router_check_ip',
    question: "هل عنوان الـ IP في جهازك ضمن نطاق 192.168.1.x؟",
    options: [
      StepOption(text: "نعم", nextStepId: 'router_browser_cache'),
      StepOption(text: "لا (يظهر 169.254.x.x)", nextStepId: 'router_dhcp_fail'),
    ],
  ),
  'router_dhcp_fail': TroubleshootingStep(
    id: 'router_dhcp_fail',
    question: "الحل التقني:",
    finalSolution: "جهازك لم يحصل على عنوان من الراوتر. قم بتعيين IP يدوي (Static IP) أو أعد تشغيل خدمة DHCP في الراوتر.",
  ),

  // ==========================================
  // 3. قسم الواي فاي (130+ سيناريو متفرع)
  // ==========================================
  'wifi_root': TroubleshootingStep(
    id: 'wifi_root',
    question: "تشخيص الواي فاي: اختر الظاهرة التي تلاحظها:",
    options: [
      StepOption(text: "الشبكة لا تظهر إطلاقاً", nextStepId: 'wifi_hidden'),
      StepOption(text: "يوجد اتصال ولكن (No Internet)", nextStepId: 'wifi_no_internet'),
      StepOption(text: "تقطيع مستمر عند الابتعاد عن الراوتر", nextStepId: 'wifi_signal_low'),
    ],
  ),
  'wifi_signal_low': TroubleshootingStep(
    id: 'wifi_signal_low',
    question: "هل تستخدم تردد 2.4GHz أم 5GHz؟",
    options: [
      StepOption(text: "تردد 5GHz", nextStepId: 'wifi_5ghz_info'),
      StepOption(text: "تردد 2.4GHz", nextStepId: 'wifi_interference_check'),
    ],
  ),
  'wifi_5ghz_info': TroubleshootingStep(
    id: 'wifi_5ghz_info',
    question: "نصيحة الخبير:",
    finalSolution: "تردد 5GHz سريع جداً لكن اختراقه للجدران ضعيف. جرب الانتقال لتردد 2.4GHz عند الابتعاد عن الغرفة.",
  ),
  'wifi_interference_check': TroubleshootingStep(
    id: 'wifi_interference_check',
    question: "هل يوجد (تلفاز، ميكرويف، أو هاتف لاسلكي) بجانب الراوتر؟",
    options: [
      StepOption(text: "نعم", nextStepId: 'wifi_move_router'),
      StepOption(text: "لا", nextStepId: 'wifi_change_channel'),
    ],
  ),
  'wifi_change_channel': TroubleshootingStep(
    id: 'wifi_change_channel',
    question: "الحل النهائي:",
    finalSolution: "قم بتغيير قناة البث (Channel) من Auto إلى 1 أو 6 أو 11 لتقليل التداخل مع الجيران.",
  ),
};