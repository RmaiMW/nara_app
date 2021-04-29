import 'package:flutter/material.dart';
import 'package:nara_app/models/article_model.dart';
import 'package:nara_app/views/blog_tile.dart';

class ArticleSavedList extends StatelessWidget {

  final List<ArticleModel> articles;
  final String NewsUrl;
  ArticleSavedList({this.articles, Key key, @required this.NewsUrl}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
      ),
      child: ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return BlogTile(
              imageUrl: articles[index].urlToImage,
              title: articles[index].title,
              desc: articles[index].description,
              url: NewsUrl,
            );
          }),
    );
  }
}
