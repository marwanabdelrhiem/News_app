import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'category_item.dart';

class CategoryListview extends StatelessWidget {
  final void Function(String categoryName) onCategoryTap;
  final String selectedCategory;

  const CategoryListview({
    super.key,
    required this.onCategoryTap,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsCategory.length,
        itemBuilder: (context, index) {
          final category = newsCategory[index];
          return CategoryItem(
            category: category,
            isSelected: category.name.toLowerCase() == selectedCategory,
            onTap: onCategoryTap,
          );
        },
      ),
    );
  }
}
