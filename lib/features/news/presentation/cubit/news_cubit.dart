import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/news_repository.dart';
import 'news_state.dart';


class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  NewsCubit({required this.newsRepository}):super(NewsInitial());
  Future<void> fetchTopHeadlines() async{
    emit(NewsLoading());
    try{
      final articles=await newsRepository.getTopHeadlines();
      emit(NewsLoaded(articles));
    }catch(e){
      emit(NewsError(e.toString()));
    }
    }
  }