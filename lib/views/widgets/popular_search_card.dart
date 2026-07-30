import 'package:flutter/material.dart';
import 'package:test/constant/app_color.dart';
import 'package:test/core/model/Search.dart';

import '../../core/model/Product.dart';

class PopularSearchCard extends StatelessWidget {
  final Product data;
  final VoidCallback onTap;
  PopularSearchCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppColor.primarySoft,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('${data.image[0]}'),
                ),
              ),
            ),
            Expanded(
              child: Text('${data.name}'),
            ),
          ],
        ),
      ),
    );
  }
}
