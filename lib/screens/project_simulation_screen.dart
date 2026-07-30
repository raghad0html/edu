import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/project_simulation_model.dart';
import '../providers/project_provider.dart';

class ProjectSimulationScreen extends StatefulWidget {
  @override
  _ProjectSimulationScreenState createState() => _ProjectSimulationScreenState();
}

class _ProjectSimulationScreenState extends State<ProjectSimulationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedProject = "مقهى إنترنت";
  final _areaController = TextEditingController();
  final _usersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF000428),
      appBar: AppBar(
        title: Text("المساعد الذكي للتصميم",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (projectProvider.currentSimulation != null)
            IconButton(
              icon: Icon(Icons.restart_alt, color: Colors.amberAccent),
              onPressed: () => projectProvider.resetSimulation(),
            )
        ],
      ),
      body: projectProvider.isProcessing
          ? _buildLoadingWidget()
          : projectProvider.currentSimulation == null
              ? _buildInputForm()
              : _buildSimulationResult(projectProvider.currentSimulation!),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.cyanAccent),
          SizedBox(height: 20),
          Text("جاري تشغيل محاكي المشاريع وحساب الـ BOM الهندسية...", style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("لنصمم مشروعك خطوة بخطوة، اختر طبيعة المنشأة:", style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedProject,
              dropdownColor: Color(0xFF000428),
              style: TextStyle(color: Colors.cyanAccent, fontSize: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
              ),
              items: ["مقهى إنترنت", "مكتب شركات صغير", "مدرسة تعليمية"].map((val) {
                return DropdownMenuItem<String>(value: val, child: Text(val));
              }).toList(),
              onChanged: (val) => setState(() => _selectedProject = val!),
            ),
            SizedBox(height: 25),
            Text("ما هي المساحة الإجمالية للمنشأة (بالمتر المربع)؟", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            TextFormField(
              controller: _areaController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: _inputDecoration("مثال: 150"),
              validator: (val) => val!.isEmpty ? "الرجاء إدخال المساحة" : null,
            ),
            SizedBox(height: 25),
            Text("كم عدد المستخدمين / الأجهزة المتوقع اتصالها؟", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            TextFormField(
              controller: _usersController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: _inputDecoration("مثال: 35"),
              validator: (val) => val!.isEmpty ? "الرجاء إدخال عدد المستخدمين" : null,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<ProjectProvider>(context, listen: false).calculateProjectRequirements(
                    projectType: _selectedProject,
                    area: double.parse(_areaController.text),
                    users: int.parse(_usersController.text),
                  );
                }
              },
              child: Text("إنشاء المخطط وجدول الكميات", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSimulationResult(ProjectSimulationResult result) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.cyanAccent,
            labelColor: Colors.cyanAccent,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.list_alt), text: "المعدات (BOM)"),
              Tab(icon: Icon(Icons.account_tree), text: "المخطط البياني"),
              Tab(icon: Icon(Icons.construction), text: "خطوات التنفيذ"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildBomTab(result.bomList),
                _buildTopologyTab(result.topologyImageUrl),
                _buildStepsTab(result.steps),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBomTab(List<BomItem> items) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: items.length,
     
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: Colors.white.withOpacity(0.06),
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(item.name, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.cyanAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                      child: Text("الكمية: ${item.quantity}", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text("تبرير الإدراج الهندسي:", style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(item.reason, style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopologyTab(String assetPath) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("مخطط توزيع الأجهزة المقترح هندسياً لضمان التغطية", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(assetPath, errorBuilder: (c, e, s) => Container(
                  height: 200,
                  color: Colors.white10,
                  child: Center(child: Icon(Icons.broken_image, color: Colors.white30, size: 50)),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsTab(List<String> steps) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.cyanAccent, width: 3),
          ),
          child: Text(steps[index], style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white30),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.cyanAccent)),
    );
  }
}