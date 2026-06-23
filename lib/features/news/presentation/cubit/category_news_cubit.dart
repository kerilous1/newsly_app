import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/news_repository.dart';
import 'category_news_state.dart';


class CategoryNewsCubit extends Cubit<CategoryNewsState> {
  final NewsRepository newsRepository;
  String currentCategory = 'all';

  CategoryNewsCubit({required this.newsRepository}):super(CategoryNewsInitial());

  Future<void> fetchCategoryNews(String category) async {
    currentCategory=category;
    emit(CategoryNewsLoading());
    try {
      final articles = await newsRepository.getNewsByCategory(category);
      emit(CategoryNewsLoaded(articles, category));
    } catch (e) {
      emit(CategoryNewsError(e.toString()));
    }
  }
}
