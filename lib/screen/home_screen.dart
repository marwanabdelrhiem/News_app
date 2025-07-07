import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_state.dart';
import 'package:news_app/widgets/article_item.dart';
import 'package:news_app/widgets/category_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: ممكن تضيف شاشة بحث هنا لاحقاً
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          else if (state is NewsSuccess) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CategoryListview(
                    onCategoryTap: (category) {
                      // تحميل الأخبار حسب الفئة المختارة
                      if (category.toLowerCase() != state.selectedCategory) {
                        context.read<NewsCubit>().fetchNews(category);
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "${state.selectedCategory.toUpperCase()} News",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ArticleItem(article: state.articles[index]);
                    },
                    childCount: state.articles.length,
                  ),
                ),
              ],
            );
          }

          else if (state is NewsError) {
            return Center(
              child: Text(
                "حدث خطأ: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // في حالة NewsInitial
          return const SizedBox();
        },
      ),
    );
  }
}