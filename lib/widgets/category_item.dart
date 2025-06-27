import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.onTap});

  final Category category;
  final void Function(String categoryName) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => onTap(category.name),
        child: CircleAvatar(
          backgroundImage: NetworkImage(category.image),
          radius: 40,
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
