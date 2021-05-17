import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nara_app/models/category_model.dart';
import 'package:nara_app/views/Fav_cat_tile.dart';
import 'package:nara_app/views/category_tile.dart';

class FavCategoryList extends StatefulWidget {
  final List<CategoryModel> categories;

  FavCategoryList({this.categories});
  @override
  _FavCategoryListState createState() => _FavCategoryListState();
}

class _FavCategoryListState extends State<FavCategoryList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
          itemCount: widget.categories.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return FavCategoryTile(
              imageUrl: widget.categories[index].imageUrl,
              categoryName: widget.categories[index].categoryName,
            );
          }),
    );
  }
}
