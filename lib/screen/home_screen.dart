import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/network/api_service.dart';
import 'package:news_app/widgets/article_item.dart';
import 'package:news_app/widgets/category_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article>? articles;
  String selectedCategory = "general";

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews([String? category]) async {
    final apiService = ApiService();
    articles = await apiService.getNews(category ?? selectedCategory);
    setState(() {});
  }

  void handleCategoryTap(String categoryName) {
    if (categoryName.toLowerCase() != selectedCategory) {
      selectedCategory = categoryName.toLowerCase();
      getNews(selectedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: articles == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CategoryListview(
              onCategoryTap: handleCategoryTap,
              selectedCategory: selectedCategory,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "${selectedCategory.toUpperCase()} News",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ArticleItem(article: articles![index]),
              childCount: articles!.length,
            ),
          ),
        ],
      ),
    );
  }
}
