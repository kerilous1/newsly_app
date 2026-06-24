import 'package:newsly/core/network/api_constants.dart';
import 'package:newsly/core/network/dio_client.dart';
import '../../data/models/article_model.dart';
import 'news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {

  final DioClient dioClient;

  NewsRepositoryImpl({required this.dioClient});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      final response = await dioClient.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {'country': ApiConstants.egCountryCode},
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
    try {
      final response = await dioClient.get(
          ApiConstants.topHeadlinesEndpoint,
          queryParameters: {
            'country': 'us',
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
