import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/category_news.dart';
import 'package:nara_app/views/loading.dart';
import 'package:nara_app/views/recommendation.dart';
import 'package:provider/provider.dart';

class FavCategoryTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  FavCategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        UserData userData = snapshot.data;
        return GestureDetector(
          onTap: () async {
            await DatabaseService(uid: user.uid).updateUserData(userData.username, userData.NewsUrl, userData.iconImage,categoryName);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Recomm(
                      cat: userData.Category,
                      //category: categoryName.toLowerCase(),
                    ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 550,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 550,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black26,
                  ),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      else {
        return Loading();
      }
    });
  }
}
