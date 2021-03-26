import 'package:firebase_auth/firebase_auth.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference naraCollection = Firestore.instance.collection('nara');

  Future<void> updateUserData(String username) async {
    return await naraCollection.document(uid).setData({
      'username': username,
    });
  }
  Future<void> updateUserDatap(String password) async {
    FirebaseUser user =await FirebaseAuth.instance.currentUser();
    user.updatePassword(password).then((_){print("Successfully changed password");
    }).catchError((error){print("Password can't be changed" + error.toString());});
  //  return await naraCollection.document(uid).setData({
   //   'password': password,
  //  });
  }
  // nara list from snapshot
  List<Nara> _naraListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Nara(
          username: doc.data['username'] ?? '',
        password:doc.data['password']??'',
      );
    }).toList();
  }


  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      password:snapshot.data['password'],
    );
  }

  // get Unara stream
  Stream<List<Nara>> get Unara {
    return naraCollection.snapshots()
        .map(_naraListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return naraCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}