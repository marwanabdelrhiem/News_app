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
    ApiService apiService = ApiService();
    articles = await apiService.getNews(category ?? selectedCategory);
    setState(() {});
  }

  void handleCategoryTap(String categoryName) {
    selectedCategory = categoryName.toLowerCase();
    getNews(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: articles == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CategoryListview(onCategoryTap: handleCategoryTap),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                selectedCategory.toUpperCase() + " News",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ArticleItem(article: articles![index]);
              },
              childCount: articles!.length,
            ),
          ),
        ],
      ),
    );
  }
}
