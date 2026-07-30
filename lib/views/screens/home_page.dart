import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/constant/app_color.dart';
import 'package:test/core/model/Category.dart';
import 'package:test/core/model/Product.dart';
import 'package:test/core/services/CategoryService.dart';
import 'package:test/core/services/ProductService.dart';
import 'package:test/views/screens/search_page.dart';
import 'package:test/views/widgets/category_card.dart';
import 'package:test/views/widgets/custom_icon_button_widget.dart';
import 'package:test/views/widgets/dummy_search_widget_1.dart';
import 'package:test/views/widgets/flashsale_countdown_tile.dart';
import 'package:test/views/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> categoryData = CategoryService.categoryData;
  final List<Product> productData = ProductService.productData;

  late Timer flashsaleCountdownTimer;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );

  @override
  void initState() {
    super.initState();
    flashsaleCountdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => updateCountdown());
  }

  void updateCountdown() {
    if (!mounted) return;
    setState(() {
      int seconds = flashsaleCountdownDuration.inSeconds - 1;
      if (seconds <= 0) {
        flashsaleCountdownTimer.cancel();
      } else {
        flashsaleCountdownDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    flashsaleCountdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String hours = flashsaleCountdownDuration.inHours
        .remainder(24)
        .toString()
        .padLeft(2, '0');
    final String minutes = flashsaleCountdownDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final String seconds = flashsaleCountdownDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _buildHeader(context),
            _buildCategorySection(),
            _buildBannerSection(),
            _buildFlashSaleSection(hours, minutes, seconds),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 190,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Find the best \n category for you.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              CustomIconButtonWidget(
                margin: EdgeInsets.all(2),
                onTap: () {},
                value: 0,
                icon: SvgPicture.asset('assets/icons/Bag.svg',
                    color: Colors.white),
              ),
            ],
          ),
          DummySearchWidget1(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      color: AppColor.secondary,
      padding: EdgeInsets.only(top: 12, bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () {},
                  child: Text('View More',
                      style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: categoryData.length,
              separatorBuilder: (_, __) => SizedBox(width: 16),
              itemBuilder: (_, i) =>
                  CategoryCard(data: categoryData[i], onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return SizedBox(
      height: 106,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(width: 16),
        itemBuilder: (_, __) => Container(
          width: 230,
          decoration: BoxDecoration(
            color: AppColor.primarySoft,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildFlashSaleSection(String hours, String minutes, String seconds) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildFlashSaleHeader(hours, minutes, seconds),
          SizedBox(height: 10),
          SizedBox(
            height: 310,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productData.length,
              itemBuilder: (context, index) {
                final product = productData[index];
                return Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemCard(
                          product: product,
                          titleColor: AppColor.primarySoft,
                          priceColor: AppColor.accent),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 180,
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                  value: 0.4,
                                  color: AppColor.accent,
                                  backgroundColor: AppColor.border,
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.local_fire_department,
                                color: AppColor.accent),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleHeader(String h, String m, String s) {
    List<Widget> _buildTimeTiles(String time) => time
        .split('')
        .map((char) => Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: FlashsaleCountdownTile(digit: char),
            ))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Flash Sale',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        Row(
          children: [
            ..._buildTimeTiles(h),
            Text(':',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            ..._buildTimeTiles(m),
            Text(':',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            ..._buildTimeTiles(s),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text('Today\'s recommendation...',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: productData
                .map((product) => ItemCard(product: product))
                .toList(),
          ),
        ),
      ],
    );
  }
}
