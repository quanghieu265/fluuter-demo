import 'package:flutter/material.dart';

class RecommendModel {
  String name;
  String icon;
  Color color;
  String describe;

  RecommendModel(
      {required this.name,
      required this.icon,
      required this.color,
      required this.describe});

  static List<RecommendModel> getRecommendModel() {
    List<RecommendModel> recommends = [];

    recommends.add(
      RecommendModel(
        name: "Honey Pancake",
        icon: 'assets/icons/honey-pancakes.svg',
        color: Colors.pink.shade100,
        describe: 'Easy | 30 mins | 180kCal',
      ),
    );
    recommends.add(RecommendModel(
      name: "Cake",
      icon: 'assets/icons/canai-bread.svg',
      color: Colors.blue.shade100,
      describe: 'Easy | 20 mins | 230kCal',
    ));

    return recommends;
  }

  // List recommend in cart
  final List<RecommendModel> _recommendCart = [];

  void addRecommendCart(RecommendModel recommendModel) {
    _recommendCart.add(recommendModel);
  }
}
