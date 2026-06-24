import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../news/data/models/article_model.dart';
import '../../data/bookmark_local_data.dart';

abstract class BookmarkState {}
class BookmarkInitial extends BookmarkState{}
class BookmarkLoaded extends BookmarkState{
  final List<ArticleModel> savedArticles;

  BookmarkLoaded(this.savedArticles);
}

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookmarkLocalData localDataSource;
  BookmarkCubit({required this.localDataSource}) : super(BookmarkInitial());

  void getSavedArticles(){
    final articles=localDataSource.getSavedArticles();
    emit(BookmarkLoaded(articles.reversed.toList()));
  }

  void toggleBookmark(ArticleModel article){
    if(article.url==null)
      return;

    final isSaved=localDataSource.isArticleSaved(article.url!);
    if(isSaved){
      localDataSource.removeArticle(article.url!);
    }else{
      localDataSource.saveArticle(article);
    }
    getSavedArticles();
  }

  bool isSaved(String url) {
    return localDataSource.isArticleSaved(url);
  }


}