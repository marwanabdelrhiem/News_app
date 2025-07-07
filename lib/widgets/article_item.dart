import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';

class ArticleItem extends StatefulWidget {
  const ArticleItem({super.key, required this.article});
  final Article article;

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.article.image ??
        "https://via.placeholder.com/300x200";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                showFullText = !showFullText;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.article.description ?? '',
                maxLines: showFullText ? null : 2,
                overflow:
                showFullText ? TextOverflow.visible : TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Text(
            widget.article.title,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
