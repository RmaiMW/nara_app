import 'package:firebase_auth/firebase_auth.dart';
import 'package:nara_app/models/Nara.dart';
import 'package:nara_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nara_app/services/auth.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  AuthService _auth = AuthService();
  // collection reference
  final CollectionReference naraCollection = Firestore.instance.collection('nara');
  Future<bool> validateCurrentPassword(String password) async {
    return await _auth.validatePassword(password);
  }

  void updateUserPassword(String password) {
    _auth.updatePassword(password);
  }
  Future<void> updateUserData(String username,String NewsUrl,String iconImage) async {
    return await naraCollection.document(uid).setData({
      'username': username,
      'NewsUrl': NewsUrl,
      'iconImage': iconImage,
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

  /*
  Future<void> updateUserURLData(List<String> URLs) async {
    FirebaseUser user =await FirebaseAuth.instance.currentUser();
    user.updateProfile(URLs: URLs).then((_){print("Successfully changed URL");
    }).catchError((error){print("Password can't be changed" + error.toString());});
    return await naraCollection.document(uid).setData({
      'URLs': URLs,
    });
  }
  Future<void> updateUserImageData(String Image) async {
    FirebaseUser user =await FirebaseAuth.instance.currentUser();
    user.updateProfile(iconImage: Image).then((_){print("Successfully changed URL");
    }).catchError((error){print("Password can't be changed" + error.toString());});

  }
  */

  // nara list from snapshot
  List<Nara> _naraListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Nara(
          username: doc.data['username'] ?? '',
      );
    }).toList();
  }


  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(

      username: snapshot.data['username'],
      NewsUrl: snapshot.data['NewsUrl'],
      iconImage: snapshot.data['iconImage']


    );
  }
  /*
  Future<void> uploadProfilePicture(File image) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(image);
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.uid);
  }

   */


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