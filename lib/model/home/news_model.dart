class NewsModel {
  String author;
  String title;
  String urlToImage;
  String content;
  String description;
  String publishedAt;
  String url;

  NewsModel(
      {required this.author,
      required this.title,
      required this.urlToImage,
      required this.content,
      required this.description,
      required this.publishedAt,
      required this.url});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      author: json['author'],
      title: json['title'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      url: json['url']);
  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'urlToImage': urlToImage,
        'content': content,
        'description': description,
        'publishedAt': publishedAt,
        'url': url
      };
}
