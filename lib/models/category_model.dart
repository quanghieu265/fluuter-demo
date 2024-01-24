import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String icon;
  Color color;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });

  static List<CategoryModel> getCategoryModel() {
    List<CategoryModel> category = [];

    category.add(CategoryModel(
        name: "Salad",
        icon: 'assets/icons/plate.svg',
        color: Colors.pink.shade100));
    category.add(CategoryModel(
        name: "Cake",
        icon: 'assets/icons/pancakes.svg',
        color: Colors.blue.shade100));
    category.add(CategoryModel(
        name: "Pie",
        icon: 'assets/icons/pie.svg',
        color: Colors.pink.shade100));
    category.add(CategoryModel(
        name: "Smoothies",
        icon: 'assets/icons/orange-snacks.svg',
        color: Colors.blue.shade100));

    return category;
  }
}
