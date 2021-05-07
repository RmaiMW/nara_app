import 'dart:convert';

import 'package:nara_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:nara_app/models/saved_model.dart';

class News {
  List<ArticleModel> news = [];
  List <SavedArticleModel> SavedNews = [];

  Future<void> getNews() async {
    String url ='https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462';
        //'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3699636a771049aca38ea30dd4ac1344';
        //https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }

  //for saved news
  Future<void> getSavedNews(List NewsUrl) async {
    String url ='https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462';
    //'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3699636a771049aca38ea30dd4ac1344';
    //https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        NewsUrl.forEach((Urls) {
          if (element['urlToImage'] != null && element['description'] != null && element['url']==Urls) {
            SavedArticleModel articleSavedModel = new SavedArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
            );

            SavedNews.add(articleSavedModel);
          }
        });
      });
    }
  }
  Future<void> getRecomNews() async {
    String url ='https://newsapi.org/v2/top-headlines?country=de&category=general&apiKey=9114be959197422d932f035b9c5bc462';
    //'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3699636a771049aca38ea30dd4ac1344';
    //https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }
  Future<void> getHotNews() async {
    String url ='https://newsapi.org/v2/top-headlines?country=de&category=health&apiKey=9114be959197422d932f035b9c5bc462';
    //'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3699636a771049aca38ea30dd4ac1344';
    //https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }


}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=9114be959197422d932f035b9c5bc462';

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

