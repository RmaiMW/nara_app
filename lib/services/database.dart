import 'package:nara_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference naraCollection = Firestore.instance.collection('nara');

  Future<void> updateUserData(String username) async {
    return await naraCollection.document(uid).setData({
      'name': username,
    });
  }


  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username']
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return naraCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}