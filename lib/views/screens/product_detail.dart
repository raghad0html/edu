import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

import '../../ar/preViewAR.dart';
import '../../constant/app_color.dart';
import '../../core/model/Product.dart';
import '../../core/model/Review.dart';
import 'reviews_page.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({required this.product});
  O3DController controller = O3DController();

  final List<Color> colors = [
    Color(0xFFD1897F),
    Color(0xFF52586D),
    Color(0xFF324D4C),
    Color(0xFFF28D35),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 245, 244),
      body: SafeArea(
        child: Column(
          children: [
            // Header and AR model
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, size: 28),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Icon(Icons.camera_alt_outlined),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          children: [
                            // Left side: text
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('IKEA',
                                      style:
                                          TextStyle(color: Colors.grey[700])),
                                  SizedBox(height: 10),
                                  Text(
                                    '${product.rating}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // Right side: 3D model
                            Expanded(
                              flex: 6,
                              child: O3D(
                                controller: controller,
                                src: product.image[1],
                                ar: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Details and Actions
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Color Options
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: colors
                            .map((color) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: color,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Rating
                    Row(
                      children: List.generate(
                        5,
                        (index) =>
                            Icon(Icons.star, color: Colors.amber, size: 20),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Description
                    Text(
                      'Comfortable chair ergonomic shape doesn’t make you '
                      'tired sitting on this chair for a long period of time. '
                      'Pokkirnya bagus banget, enjoy duduk disini, and the time '
                      'you spend akan terasa nyaman.\n\nRead More',
                      style: TextStyle(color: Colors.grey[700], height: 1.4),
                    ),
                    SizedBox(height: 10),

                    // Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text('1', style: TextStyle(fontSize: 16)),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ARPreviewScreen(
                                        img: product.image[1],
                                      )),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 12),
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('View in AR',
                              style: TextStyle(color: Colors.black)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewsPage(reviews: product.reviews),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Add to cart'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
