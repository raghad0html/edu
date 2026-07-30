import 'package:flutter/cupertino.dart';
import 'package:test/core/model/ColorWay.dart';
import 'package:test/core/model/ProductSize.dart';
import 'package:test/core/model/Review.dart';

class Product {
  List<String> image;
  String name;

  double rating;
  String description;

  List<Review> reviews;
  String storeName;

  Product({
    required this.image,
    required this.name,
    required this.rating,
    required this.description,
    required this.reviews,
    required this.storeName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      name: json['name'],
      rating: json['rating'],
      description: json['description'],
      reviews: (json['reviews'] as List)
          .map((data) => Review.fromJson(data))
          .toList(),
      storeName: json['store_name'],
    );
  }
}
