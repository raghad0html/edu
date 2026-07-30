import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceDirectoryProvider with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _isListening = false;
  String _wordsSpoken = "اضغط على المايك وابدأ التحدث..";
  String? _detectedProduct;

  bool get isListening => _isListening;
  String get wordsSpoken => _wordsSpoken;
  String? get detectedProduct => _detectedProduct;

  VoiceDirectoryProvider() {
    _initTts();
  }

  void _initTts() async {
    await _tts.setLanguage("ar"); // ضبط القراءة الصوتية للغة العربية
    await _tts.setSpeechRate(0.5); // ضبط سرعة القراءة لتكون واضحة تعليمياً
  }

  void startListening(Function(String) onMatchFound) async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (available) {
      _isListening = true;
      _wordsSpoken = "أنا أستمع إليك الآن...";
      _detectedProduct = null;
      notifyListeners();

      await _speech.listen(
        onResult: (result) {
          _wordsSpoken = result.recognizedWords;
          notifyListeners();
          
          if (result.finalResult) {
            _processVoiceCommand(_wordsSpoken, onMatchFound);
          }
        },
        localeId: "ar_SA", // ضبط الالتقاط الصوتي على اللهجة العربية
      );
    }
  }

  void stopListening() async {
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  void _processVoiceCommand(String command, Function(String) onMatchFound) {
    _isListening = false;
    String cleanCommand = command.toLowerCase();

    // هندسة الفهرسة الصوتي التفاعلية للكلمات المفتاحية
    if (cleanCommand.contains("فايبر") || cleanCommand.contains("fiber") || cleanCommand.contains("ضوئي")) {
      _detectedProduct = "كبل الـ Fiber Optic";
      onMatchFound(_detectedProduct!);
      speakText("هو كبل ينقل البيانات كنبضات ضوئية، يمتاز بالسرعة العالية جداً ومقاومة التشويش الكهرومغناطيسي.");
    } else if (cleanCommand.contains("راوتر") || cleanCommand.contains("router")) {
      _detectedProduct = "الراوتر الذكي";
      onMatchFound(_detectedProduct!);
      speakText("هو جهاز يقوم بتوجيه حزم البيانات بين الشبكات المختلفة ويربط شبكتك المحلية بالإنترنت.");
    } else {
      _wordsSpoken = "لم أفهم المصطلح جيداً، حاول قول: ما هو كبل الفايبر؟";
      speakText("عذراً، لم أتعرف على المصطلح التقني بنجاح.");
    }
    notifyListeners();
  }

  void speakText(String text) async {
    await _tts.speak(text);
  }

  void stopSpeaking() async {
    await _tts.stop();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}