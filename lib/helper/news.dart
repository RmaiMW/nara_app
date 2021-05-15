import 'dart:convert';

import 'package:nara_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:nara_app/models/saved_model.dart';

class News {
  List<ArticleModel> news = [];
  List <SavedArticleModel> SavedNews = [];
  List<int> all_news = [];
  List<ArticleModel> agnews=[];
  List api = [];

  Future<void> getNews() async {
 //   String url ='https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462';
        //'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3699636a771049aca38ea30dd4ac1344';
        //https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462

    var rese = await http.get("http://10.0.2.2/NARA-app/connect.php");
    if (rese.statusCode == 200) {
      api = json.decode(rese.body);
      all_news.add(0);
      for(int i=0;i<api.length;i++) {
        String url = api[i];

        var response = await http.get(url);

        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = new ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                url: element['url'],
                urlToImage: element['urlToImage'],
                content: element['content'],
              );

              agnews.add(articleModel);
            }
          });
        }
        all_news.add(agnews.length);
      }//for
  }
    int n=0;
    int counter=0;
    while(n<agnews.length-1 ){
      for(int j=0;j<all_news.length-1;j++){
        n=counter+all_news[j];
        if(n>agnews.length-1) return;
        else
        news.add(agnews[n]);
      }
      counter++;
    }
    print(news.length);
    print(agnews.length);
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
    var rese = await http.get("http://10.0.2.2/NARA-app/connect.php");
    if (rese.statusCode == 200) {
      api = json.decode(rese.body);
      all_news.add(0);
      for(int i=0;i<api.length;i++) {
        String url = api[i];

        var response = await http.get(url);

        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = new ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                url: element['url'],
                urlToImage: element['urlToImage'],
                content: element['content'],
              );

              agnews.add(articleModel);
            }
          });
        }
        all_news.add(agnews.length);
      }//for
    }
    for(int i=0;i<all_news.length-1;i++){
      news.add(agnews[all_news[i]]);

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

