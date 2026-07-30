import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/bot_provider.dart';

class BotScreen extends StatefulWidget {
  @override
  _BotScreenState createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  String currentStepId = 'start';

  @override
  void initState() {
    super.initState();
    // تحميل البيانات من الـ JSON عند بدء الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BotProvider>(context, listen: false).loadKnowledgeBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final botProvider = Provider.of<BotProvider>(context);

    if (botProvider.isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFF000428),
        body: Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
      );
    }

    final step = botProvider.getStep(currentStepId);

    // معالجة حالة إذا كان الـ ID غير موجود في الـ JSON لتجنب الانهيار
    if (step == null) {
      return Scaffold(
        backgroundColor: Color(0xFF000428),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("خطأ: الخطوة غير موجودة ($currentStepId)", style: TextStyle(color: Colors.red)),
              ElevatedButton(onPressed: () => setState(() => currentStepId = 'start'), child: Text("العودة للبداية"))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF000428), // Deep Blue
      appBar: AppBar(
        title: Text("المساعد الذكي للشبكات",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: () => setState(() => currentStepId = 'start'),
            tooltip: "إعادة تعيين",
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatArea(step),
          ),
          // منطقة الأزرار: تظهر الخيارات إذا وجدت، أو زر إعادة البدء إذا وصلنا للحل النهائي
          _buildActionArea(step),
        ],
      ),
    );
  }

  Widget _buildChatArea(Map<String, dynamic> step) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // فقاعة السؤال (Bot Message)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Text(
                step['question'] ?? "",
                style: TextStyle(color: Colors.white, fontSize: 18, height: 1.4),
              ),
            ),
          ),
          
          SizedBox(height: 25),

          // عرض الحل النهائي (Final Solution) إذا كان موجوداً في الـ JSON
          if (step.containsKey('final') && step['final'] != null)
            _buildFinalSolutionCard(step['final']),
        ],
      ),
    );
  }

  Widget _buildFinalSolutionCard(String solution) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green.withOpacity(0.3), Colors.blue.withOpacity(0.2)]),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.5), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 40),
          SizedBox(height: 12),
          Text(
            "الحل المقترح:",
            style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            solution,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildActionArea(Map<String, dynamic> step) {
    // إذا كان هناك خيارات (Options)
    if (step.containsKey('options') && step['options'] != null) {
      return Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: (step['options'] as List).map((opt) {
            return ActionChip(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              label: Text(opt['text'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () => setState(() => currentStepId = opt['next']),
            );
          }).toList(),
        ),
      );
    } 
    // إذا لم تكن هناك خيارات (وصلنا للحل النهائي)
    else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: ElevatedButton.icon(
          onPressed: () => setState(() => currentStepId = 'start'),
          icon: Icon(Icons.replay),
          label: Text("حل مشكلة أخرى"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      );
    }
  }
}