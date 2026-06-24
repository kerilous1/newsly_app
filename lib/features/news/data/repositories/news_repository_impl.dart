import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_constants.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {

  final DioClient dioClient;

  NewsRepositoryImpl({required this.dioClient});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      final response = await dioClient.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {
          'country': ApiConstants.usCountryCode,
        },
      );

      List<dynamic> articlesJson = response.data['articles'];
      List<ArticleModel> articles = articlesJson.map((json) {
        return ArticleModel.fromeJson(json);
      }).toList();

      return articles;
      
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getNewsByCategory(String category) async {
    try{
      final response = await dioClient.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {
          'country': 'us',
          'pageSize': 100,
          if(category != 'all')'category': category
        }
      );
      List<dynamic> articlesJson = response.data['articles'];
      List<ArticleModel> articles = articlesJson.map((json) =>
          ArticleModel.fromeJson(json)).toList();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}