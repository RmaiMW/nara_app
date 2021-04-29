import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nara_app/helper/news.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/views/article_view.dart';
import 'package:nara_app/views/blog_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';



class Search extends SearchDelegate<ArticleModel>{
final _api='https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=9114be959197422d932f035b9c5bc462';
final List<ArticleModel> article;// = new List<ArticleModel>();

String s;
  Search(this.article);


 @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(icon: Icon(Icons.clear),
          onPressed: ()=>query="",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if(query == '') return Center(child: Text('Enter Keyword'),);
    return ListView(
        children: article.where((element) => element.title.toLowerCase().contains(query)).map<BlogTile>((e) =>
            BlogTile(imageUrl: e.urlToImage, title: e.title, desc: '', url: e.url)
      ).toList()          );



  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    ArticleModel a=new ArticleModel(
      title: 'No News',
      author: '',
      description: '',
      url: '',
      urlToImage: '',
      content: '',
    );
    List<ArticleModel> result = [];
    result.add(a);
    List<ArticleModel> suggestions=[];
    query.isEmpty ? suggestions=result:suggestions.addAll(
      article.where((element) => element.title.toLowerCase().contains(query)));


       return ListView(
          children:query.isEmpty?result.map<ListTile>((e) => ListTile(
            title: Text(e.title),
            leading: SizedBox(),
          )).toList():
          suggestions.map<BlogTile>((e) => BlogTile(
            title: e.title,
            imageUrl: e.urlToImage,
            desc: '', url: e.url,
          )).toList(),


       );


  }



}