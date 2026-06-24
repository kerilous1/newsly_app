class ArticleModel {
  final String tital;
  final String? description;
  final String? url;
  final String? imageUrl;
  final String? publishedAt;
  final String sourceName;
  ArticleModel({
    required this.tital,
    this.description,
    this.url,
    this.imageUrl,
    this.publishedAt,
    required this.sourceName
  });
  factory ArticleModel.fromeJson(Map<String,dynamic> json){
    return ArticleModel(
      tital: json['title']??'No title',
      description: json['description'],
      url: json['url'],
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'],
      sourceName: json['source']?['name']??'Unknown Source',
    );
  }
  Map<String,dynamic>toJson(){
    return {
      'title':tital,
      'description':description,
      'url':url,
      'urlToImage':imageUrl,
      'publishedAt':publishedAt,
      'source':{'name':sourceName},
    };
  }
}