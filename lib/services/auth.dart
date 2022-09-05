import 'package:firebase_auth/firebase_auth.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/services/database.dart';

import 'dart:developer' as dev;

import 'package:higym/zzz_deleteable/databaseOld.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  //create user obj based on FireBaseUser(after update => User)
  AppUser? _userFromFireBaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password, String userName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(userName,email);
      return _userFromFireBaseUser(user);
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }
}
