import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voice_directory_provider.dart';

class VoiceDirectoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final voiceProvider = Provider.of<VoiceDirectoryProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF000428),
      appBar: AppBar(
        title: Text("دليل البحث الصوتي الذكي",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
            // تلميح تفاعلي علوي
            Card(
              color: Colors.white.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.amberAccent),
                    SizedBox(width: 10),
                    Expanded(child: Text("جرب نطق: 'ما هو كبل الـ Fiber Optic؟' أثناء تركيبك للمعدات.", style: TextStyle(color: Colors.grey, fontSize: 13))),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // منطقة عرض الكلام المنطوق وتحليله
            Expanded(
              child: Center(
                child: voiceProvider.detectedProduct == null
                    ? Text(
                        voiceProvider.wordsSpoken,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 18, fontStyle: FontStyle.italic),
                      )
                    : _buildProductDetailsCard(voiceProvider.detectedProduct!),
              ),
            ),

            // زر المايك التفاعلي السفلي مع الأنيميشن الافتراضي
            Center(
              child: GestureDetector(
                onTapDown: (_) => voiceProvider.startListening((matchedProduct) {
                  print("تم العثور على المنتج: $matchedProduct");
                }),
                onTapUp: (_) => voiceProvider.stopListening(),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(voiceProvider.isListening ? 25 : 18),
                  decoration: BoxDecoration(
                    color: voiceProvider.isListening ? Colors.redAccent : Colors.blueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: voiceProvider.isListening ? Colors.redAccent.withOpacity(0.5) : Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Icon(
                    voiceProvider.isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                voiceProvider.isListening ? "اترك يدك عند الانتهاء من النطق" : "اضغط مطولاً للتحدث دون استخدام يديك",
                style: TextStyle(color: Colors.white30, fontSize: 12),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // بناء كرت عرض التفاصيل التقنية الدقيقة للمنتج المكتشف صوتاً
  Widget _buildProductDetailsCard(String productName) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.white.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(productName, style: TextStyle(color: Colors.cyanAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                  Icon(Icons.volume_up, color: Colors.cyanAccent),
                ],
              ),
              SizedBox(height: 15),
              // محاكاة صورة مقربة للمنتج الفني
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.cable, color: Colors.white24, size: 60),
              ),
              SizedBox(height: 15),
              Text("الوصف الفني:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(
                "كبلات متطورة مصنوعة من خيوط زجاجية نقية رقيقة للغاية تنقل البيانات على شكل نبضات ضوئية يتم توليدها بواسطة الليزر.",
                style: TextStyle(color: Colors.grey, height: 1.4, fontSize: 14),
              ),
              SizedBox(height: 15),
              Text("أهم الاستخدامات الميدانية:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("• ربط كبائن الاتصالات الرئيسية (Backbone Core).\n• الربط السريع لمراكز البيانات والـ Servers.\n• خطوط الإنترنت العابرة للقارات والـ FTTH للمنازل.", style: TextStyle(color: Colors.grey, height: 1.5, fontSize: 13)),
              SizedBox(height: 15),
              // جدول مقارنة فنية سريع للطالب
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    _buildRowComparison("وجه المقارنة", "الفايبر الزجاجي", "الكبل النحاسي (Cat6)", isHeader: true),
                    Divider(color: Colors.white12),
                    _buildRowComparison("سرعة النقل", "تصل لـ 100 Gbps", "تصل لـ 1 Gbps"),
                    _buildRowComparison("التأثر بالتشويش", "مقاوم تماماً", "يتأثر بالموجات القريبة"),
                    _buildRowComparison("أقصى مسافة", "عشرات الكيلومترات", "100 متر فقط"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowComparison(String title, String val1, String val2, {bool isHeader = false}) {
    final style = TextStyle(
      color: isHeader ? Colors.cyanAccent : Colors.white70,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontSize: isHeader ? 13 : 12,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(title, style: style)),
          Expanded(flex: 2, child: Text(val1, style: style)),
          Expanded(flex: 2, child: Text(val2, style: style)),
        ],
      ),
    );
  }
}