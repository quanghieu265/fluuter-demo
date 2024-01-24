import 'package:demo1/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryFnc extends StatelessWidget {
  const CategoryFnc({
    super.key,
    required this.category,
  });

  final List<CategoryModel> category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 120,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              shrinkWrap: true,
              itemCount: category.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: category[index].color.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: SvgPicture.asset(category[index].icon),
                        ),
                        Text(category[index].name)
                      ]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
