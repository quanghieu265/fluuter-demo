import 'package:demo1/models/category_model.dart';
import 'package:demo1/models/popular_model.dart';
import 'package:demo1/models/recommend_model.dart';
import 'package:demo1/widgets/activity_widget.dart';
import 'package:demo1/widgets/popular_widget.dart';
import 'package:demo1/widgets/recommend_widget.dart';
import 'package:demo1/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/category_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> category = [];

  List<RecommendModel> recommends = [];

  List<PopularModal> popular = [];

  void getInitData() {
    category = CategoryModel.getCategoryModel();
    recommends = RecommendModel.getRecommendModel();
    popular = PopularModal.getPopularList();
  }

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.vertical, children: [
      const SearchFieldsFnc(),
      CategoryFnc(category: category),
      RecommendFnc(recommends: recommends),
      PopularFnc(popular: popular),
      const ActivityFnc()
    ]);
  }
}
