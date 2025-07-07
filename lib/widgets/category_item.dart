import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final void Function(String categoryName) onTap;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => onTap(category.name),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: isSelected ? Colors.indigo : Colors.grey[300],
              backgroundImage: NetworkImage(category.image),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 5),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.indigo, size: 16),
          ],
        ),
      ),
    );
  }
}
