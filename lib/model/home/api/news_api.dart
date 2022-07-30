import 'package:dio/dio.dart';
import 'package:vaccine_booking/model/home/news_model.dart';

class NewsApi {
  Future<List<NewsModel>> getAllNews() async {
    final response = await Dio().get(
        "https://newsapi.org/v2/everything?q=covid&language=id&apiKey=23b92eb137c74f6eab5f15055aa1de69");
    final newsList = (response.data['articles'] as List)
        .map(
          (e) => NewsModel.fromJson(e),
        )
        .toList();
    return newsList;
  }
}
