import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class ArPage extends StatefulWidget {
  const ArPage({super.key, required this.title, required this.id});
  final int id;
  final String title;

  @override
  State<ArPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ArPage> {
  // to control the animation
  final O3DController controller = O3DController(),
      controller2 = O3DController(),
      controller3 = O3DController(),
      controller4 = O3DController();
  List<String> logs = [];
  bool cameraControls = false;

  List<String>? availableVariants;
  List<String>? availableAnimations;
  List<String> all = [
    'assets/glb/badroom/Azure_Comfort_0425172030_texture.glb',
  ];
  @override
  void initState() {
    super.initState();
    controller.logger = (data) {
      logs.add(data.toString());
    };
    if (widget.id == 1) {
      all = [
        'assets/glb/badroom/Azure_Comfort_0425172030_texture.glb',
        'assets/glb/badroom/Elegant_Tufted_Bed_0425172822_texture.glb',
        'assets/glb/badroom/Golden_Serenity_Bed_0426102249_texture.glb',
        'assets/glb/badroom/Gray_Tufted_Bed_0426094507_texture.glb',
        'assets/glb/badroom/Green_Cozy_Bed_0425172301_texture.glb',
        'assets/glb/badroom/Green_Upholstered_Bed_0425173138_texture.glb',
        'assets/glb/badroom/Sleek_Comfort_Bedset_0426102537_texture.glb',
        'assets/glb/badroom/Velvet_Elegance_Bed_0425170312_texture.glb',
      ];
    } else if (widget.id == 2) {
      all = [
        'assets/glb/sofra/Cozy_Dining_Set_0426105305_texture.glb',
        'assets/glb/sofra/Dining_Ensemble_0426092918_texture.glb',
        'assets/glb/sofra/Elegant_Dining_Arrang_0426093353_texture.glb',
        'assets/glb/sofra/Marble_Elegance_Set_0426093704_texture.glb',
        'assets/glb/sofra/Modern_Dining_Ensembl_0426105002_texture.glb',
        'assets/glb/sofra/Modern_Dining_Set_0426094109_texture.glb',
        'assets/glb/sofra/Modern_Dining_Set_0426105516_texture.glb',
        'assets/glb/sofra/Oval_Elegance_Dining__0426105656_texture.glb',
        'assets/glb/sofra/Round_Elegance_Dining_0426092617_texture.glb',
      ];
    } else if (widget.id == 3) {
      all = [
        'assets/glb/mkjb/Conference_Workspace__0426094930_texture.glb',
        'assets/glb/mkjb/Modern_Office_Workspa_0426095720_texture.glb',
        'assets/glb/mkjb/Modern_Workspace_Desi_0426101431_texture.glb',
        'assets/glb/mkjb/Study_Nook_Serenity_0426095519_texture.glb',
        'assets/glb/mkjb/Workspace_Elegance_0426110528_texture.glb',
        'assets/glb/mkjb/Workspace_Harmony_0426101629_texture.glb',
        'assets/glb/mkjb/Workspace_Serenity_0420135711_texture.glb',
      ];
    } else if (widget.id == 4) {
      all = [
        'assets/glb/cheken/Modern_Charcoal_Kitch_0426090439_texture.glb',
        'assets/glb/cheken/Modern_Kitchen_Design_0426091531_texture.glb',
        'assets/glb/cheken/Modern_Kitchen_Design_0426092004_texture.glb',
        'assets/glb/cheken/Modern_Marble_Kitchen_0426091211_texture.glb',
        'assets/glb/cheken/Modern_Minimalist_Kit_0426092127_texture.glb'
      ];
    } else {
      all = [
        'assets/glb/light/Crimson_Glow_0426115310_texture.glb',
        'assets/glb/light/Curved_Elegance_Lamp_0426114930_texture.glb',
        'assets/glb/light/Giant_Task_Lamp_0426114642_texture.glb',
        'assets/glb/light/Golden_Elegance_Lamp_0426113732_texture.glb',
        'assets/glb/light/Modern_Desk_Lamps_0426110747_texture.glb',
        'assets/glb/light/Modern_Elegance_Lamps_0426111543_texture.glb',
        'assets/glb/light/Terracotta_Glow_Lamp_0426111741_texture.glb'
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            itemCount: all.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => ModelDetail(
                  actions: [],
                  o3d: O3D(
                    ar: true,
                    controller: controller,
                    backgroundColor: Colors.blue,
                    src: all[index],
                  ),
                )));
  }
}

class ModelDetail extends StatelessWidget {
  final List<Widget> actions;
  final Widget o3d;

  const ModelDetail({
    super.key,
    required this.actions,
    required this.o3d,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 0,
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.infinity,
        height: 400,
        child: Column(
          children: [
            Wrap(
              children: actions
                  .map((child) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: child,
                      ))
                  .toList(),
            ),
            Expanded(
                child: Card(
              color: Colors.blue.withOpacity(.3),
              elevation: 0,
              child: AspectRatio(aspectRatio: 1, child: o3d),
            ))
          ],
        ),
      ),
    );
  }
}
