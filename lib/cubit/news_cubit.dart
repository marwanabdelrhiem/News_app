import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/network.dart';
import 'package:news_app/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> fetchNews([String category = "general"]) async {
    emit(NewsLoading());
    try {
      final articles = await ApiService().getNews(category);
      emit(NewsSuccess(articles: articles, selectedCategory: category));
    } catch (e) {
      emit(NewsError("Failed to load news: $e"));
    }
  }
}
