class StepOption {
  final String text; // نص الخيار (نعم / لا)
  final String nextStepId; // المعرف للخطوة التالية

  StepOption({required this.text, required this.nextStepId});
}

class TroubleshootingStep {
  final String id;
  final String question; // السؤال الذي يطرحه البوت
  final String? mediaUrl; // رابط GIF أو صورة توضيحية
  final List<StepOption>? options; // الخيارات المتاحة للطالب
  final String? finalSolution; // الحل النهائي إذا وصلنا لنهاية الشجرة

  TroubleshootingStep({
    required this.id,
    required this.question,
    this.mediaUrl,
    this.options,
    this.finalSolution,
  });
}