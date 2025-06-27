import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';

import 'category_item.dart';
class CategoryListview extends StatelessWidget {
  final void Function(String categoryName) onCategoryTap;
  const CategoryListview({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsCategory.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            category: newsCategory[index],
            onTap: onCategoryTap,
          );
        },
      ),
    );
  }
}

