//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nara_app/models/user.dart';
import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
     // .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      //anonymous =true;
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
/*
  Future  <void> signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
    print(graphResponse.body);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
      _auth.signInWithCredential(credential);
    }
  }


 */

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential =
      GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('$username'??'new user', [],'','');
     //await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(user);
      //return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signout()  async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
    Future <bool> validatePassword(String password) async {
      //FirebaseUser firebaseUser =await FirebaseAuth.instance.currentUser();
      //return true;
      var _firebaseUser = await _auth.currentUser();
      final AuthCredential authCredentials = EmailAuthProvider.getCredential(
          email: _firebaseUser.email, password: password);
      print(_firebaseUser.email);
      print(password);
      try {
        //var _firebaseUser = await _auth.currentUser();
          var authRes = await _firebaseUser.reauthenticateWithCredential(authCredentials);
          print(authRes.user != null);
          return (authRes.user != null);
        }catch(e){
            print(e);
            return false;
        }

    }

    Future<void> updatePassword(String password) async {
      var firebaseUser = await _auth.currentUser();
      firebaseUser.updatePassword(password);
    }

    Future<void> deleteUser() async{
      try {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        user.delete();
      } catch (e) {
        if (e.code == 'requires-recent-login') {
          print(
              'The user must reauthenticate before this operation can be executed.');
        }
      }
    }






}