
class User {

  final String uid;
  final String username;

  User({this.uid,this.username});

}

class UserData {
  String username;
  // ignore: non_constant_identifier_names
  List NewsUrl =[];
  String iconImage;



  // ignore: non_constant_identifier_names
  UserData({this.username,this.NewsUrl,this.iconImage});

  UserData.fromMap(Map<String, dynamic> data){
    //username = data['username'];
    NewsUrl = data['NewsUrl'];
    //iconImage = data['iconImage'];

  }
  Map<String, dynamic> toMap(){
    return{
      //'username' : username,
      'NewsUrl' : NewsUrl,
      //'iconImage' : iconImage,
    };
  }


}