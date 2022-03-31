import 'package:cube_ctrl/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  model.User? _userFromFirebaseUser(User? user) {
    return user != null ? model.User(uid: user.uid) : null;
  }


  Stream<model.User?>get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user)
    );
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result= await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email,String password) async {
    try {
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
    }
  }

  //sign in with email & password
  Future registerWithEmailAndPassword(String email,String password) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}