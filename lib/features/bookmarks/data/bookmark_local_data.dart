import 'package:hive/hive.dart';
import 'package:newsly/features/news/data/models/article_model.dart';

class BookmarkLocalData {
  final String boxName='bookMarkBox';

  List<ArticleModel> getSavedArticles() {
    final box = Hive.box(boxName);

    return box.values.map((item) {
      return ArticleModel.fromeJson(Map<String, dynamic>.from(item));
    }).toList();
  }

  Future<void> saveArticle(ArticleModel article) async {
    final box = Hive.box(boxName);
    if(article.url !=null){
      await box.put(article.url, article.toJson());
    }
  }

  Future<void> removeArticle(String url) async {
    final box = Hive.box(boxName);
    await box.delete(url);
    }

  bool isArticleSaved(String url) {
    final box = Hive.box(boxName);
    return box.containsKey(url);
  }
}
