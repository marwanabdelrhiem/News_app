import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/network/api_service.dart';
import 'article_item.dart';

class ArticleListview extends StatefulWidget {
  const ArticleListview({super.key});

  @override
  State<ArticleListview> createState() => _ArticleListviewState();
}

class _ArticleListviewState extends State<ArticleListview> {
  List<Article>? articles;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiService = ApiService();
    final data = await apiService.getNews();
    setState(() {
      articles = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (articles == null) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => ArticleItem(article: articles![index]),
        childCount: articles!.length,
      ),
    );
  }
}
