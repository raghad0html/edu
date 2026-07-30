import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/constant/app_color.dart';
import 'package:test/core/model/Review.dart';
import 'package:test/views/widgets/custom_app_bar.dart';
import 'package:test/views/widgets/review_tile.dart';

class ReviewsPage extends StatefulWidget {
  final List<Review> reviews;
  ReviewsPage({required this.reviews});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  int _selectedTab = 0;

  double getAverageRating() {
    double average = 0.0;
    for (var review in widget.reviews) {
      average += review.rating;
    }
    return average / widget.reviews.length;
  }

  List<Review> filterReviewsByRating(int rating) {
    return widget.reviews
        .where((review) => review.rating.toInt() == rating)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: 'Reviews',
            leftIcon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
            rightIcon: SvgPicture.asset(
              'assets/icons/Bookmark.svg',
              color: Colors.black.withOpacity(0.5),
            ),
            leftOnTap: () => Navigator.of(context).pop(),
            rightOnTap: () {},
          ),
        ),
        body: Column(
          children: [
            // Header
            Container(
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getAverageRating().toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Based on ${widget.reviews.length} Reviews',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(6, (i) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedTab = i;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: i == 0
                          ? [
                              Text(
                                'All',
                                style: TextStyle(
                                  color: (_selectedTab == i)
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ]
                          : [
                              SvgPicture.asset(
                                'assets/icons/Star-active.svg',
                                width: 14,
                                height: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '$i',
                                style: TextStyle(
                                  color: (_selectedTab == i)
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_selectedTab == i) ? AppColor.primary : Colors.white,
                      foregroundColor: AppColor.border,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColor.border),
                      ),
                      elevation: 0,
                    ),
                  );
                }),
              ),
            ),

            // Reviews List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: (_selectedTab == 0)
                    ? widget.reviews.length
                    : filterReviewsByRating(_selectedTab).length,
                itemBuilder: (context, index) {
                  final review = (_selectedTab == 0)
                      ? widget.reviews[index]
                      : filterReviewsByRating(_selectedTab)[index];
                  return ReviewTile(review: review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
