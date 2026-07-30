import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

import '../constant/app_color.dart';

class ARPreviewScreen extends StatelessWidget {
  String img;
  ARPreviewScreen({required this.img});
  final O3DController controller = O3DController();

  final List<Color> colors = [
    Color(0xFFF28D35),
    Color(0xFFD1897F),
    Color(0xFF324D4C),
    Color(0xFF52586D),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.4),
      body: SafeArea(
        child: Stack(
          children: [
            // Chair 3D Model in Center
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 3 / 4,
                child: O3D(
                  ar: true,
                  controller: controller,
                  src: img,
                ),
              ),
            ),

            // Back button (top left)
            Positioned(
              left: 16,
              top: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // Color selectors (vertical right)
            Positioned(
              right: 16,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  ...colors.map(
                    (color) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: color,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
