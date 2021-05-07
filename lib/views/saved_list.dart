import 'package:flutter/material.dart';
import 'package:nara_app/models/saved_model.dart';
import 'package:nara_app/views/saved_blog_tile.dart';

class SavedArticleList extends StatelessWidget {
  final List<SavedArticleModel> articles;

  SavedArticleList({this.articles});

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
            return SavedBlogTile(
              imageUrl: articles[index].urlToImage,
              title: articles[index].title,
              desc: articles[index].description,
              url: articles[index].url,
            );
          }),
    );
  }
}
