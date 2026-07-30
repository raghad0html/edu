import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RouterArRecognizerView extends StatefulWidget {
  const RouterArRecognizerView({Key? key}) : super(key: key);

  @override
  State<RouterArRecognizerView> createState() => _RouterArRecognizerViewState();
}

class _RouterArRecognizerViewState extends State<RouterArRecognizerView> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  // الاحتفاظ بالنقاط المضافة لإدارتها أو حذفها
  List<ARNode> nodes = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التعرف البصري - راوتر TP-Link',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,),
      body: Stack(
        children: [
          // 1. عرض كاميرا الواقع المعزز
          ARView(
            onARViewCreated: onARViewCreated,
          ),
          // 2. واجهة إرشادية للمستخدم فوق الكاميرا
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'وجه الكاميرا نحو خلفية الراوتر لإظهار منافذ التوصيل',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign:TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  // يتم استدعاء هذه الدالة فور تشغيل الكاميرا بنجاح
  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {

    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    // تشغيل الجلسة وتتبع الأسطح أو الأجسام
    this.arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true, // لإيجاد السطح الذي يرتكز عليه الراوتر
      showWorldOrigin: false,
    );
    this.arObjectManager!.onInitialize();

    // هنا نقوم بمحاكاة رصد الراوتر وإضافة النقاط التفاعلية فوق المنافذ
    // في التطبيق الفعلي، تستدعي هذه الدالة بعد أن يؤكد نموذج الذكاء الاصطناعي (ML Kit) التعرف على الراوتر
    _addRouterHotspots();
  }

  Future<void> _addRouterHotspots() async {
    // 1. إضافة سهم أو نقطة فوق منفذ WAN
    // الإحداثيات (X, Y, Z) تحدد مكان السهم في الفضاء ثلاثي الأبعاد
    var wanNode = ARNode(
      type: NodeType.localGLTF2, // استخدام مجسم ثلاثي الأبعاد للسهم (الملف يوضع في الـ assets)
      uri: "assets/models/arrow.gltf",
      scale: vector.Vector3(0.2, 0.2, 0.2),
      position: vector.Vector3(-0.1, 0.0, -0.5), // مكان منفذ WAN افتراضياً
      rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
    );

    bool? didAddWan = await arObjectManager?.addNode(wanNode);
    if (didAddWan ?? false) {
      nodes.add(wanNode);
    }

    // 2. إضافة سهم أو نقطة فوق منافذ LAN
    var lanNode = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/arrow.gltf",
      scale: vector.Vector3(0.2, 0.2, 0.2),
      position: vector.Vector3(0.1, 0.0, -0.5), // مكان منافذ LAN بجانب منفذ WAN
      rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
    );

    bool? didAddLan = await arObjectManager?.addNode(lanNode);
    if (didAddLan ?? false) {
      nodes.add(lanNode);
    }

    // إعداد التفاعل عند النقر على النقاط (Hotspots) لإظهار الشرح للطالب
    arObjectManager?.onNodeTap = (nodeNames) {
      final tappedNode = nodeNames.first;

      if (tappedNode == wanNode.name) {
        _showInfoBottomSheet("منفذ WAN (المنفذ الأزرق)", "هنا يتم توصيل كبل الإنترنت القادم من مزود الخدمة (Modem/Provider).");
      } else if (tappedNode == lanNode.name) {
        _showInfoBottomSheet("منافذ LAN (المنافذ الصفراء)", "تستخدم لتوصيل الأجهزة المحلية (كمبيوتر، شاشة، سيرفر) وتدعم سرعات تصل إلى 1 Gbps.");
      }
    };
  }

  void _showInfoBottomSheet(String title, String description) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 10),
              Text(description, style: const TextStyle(fontSize: 16, height: 1.4)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}