
import 'package:equatable/equatable.dart';

import '../../data/models/article_model.dart';

abstract class CategoryNewsState extends Equatable {
  const CategoryNewsState();
  @override
  List<Object> get props => [];
}

class CategoryNewsInitial extends CategoryNewsState {}

class CategoryNewsLoading extends CategoryNewsState {}

class CategoryNewsLoaded extends CategoryNewsState {
  final List<ArticleModel> articles;
  final String selectedCategory;
  const CategoryNewsLoaded(
      this.articles,
      this.selectedCategory,
      );

  @override
  List<Object> get props => [articles, selectedCategory];
}

class CategoryNewsError extends CategoryNewsState {
  final String message;
  const CategoryNewsError(this.message);
  @override
  List<Object> get props => [message];
}
