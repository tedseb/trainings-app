import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:higym/app_utils/helper_utils.dart';
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
  Stream<User?> get user {
    return _auth.authStateChanges();//.map(_userFromFireBaseUser);
  }

  /// Sign In With Google
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);

    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('testGoogleName', 'testGoogleMail');
      return _userFromFireBaseUser(user);
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

      User? user = result.user;
      bool userverified = user!.emailVerified;
      if (userverified) {
        return _userFromFireBaseUser(user);
      } else {
        user.sendEmailVerification();
        return false;
      }
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password, String userName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;
      user!.sendEmailVerification();
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(userName, email);
      return _userFromFireBaseUser(user);
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Reset Password
  Future resetPassword(var context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      showSnackbar(context, 'Password Reset Email Send');
      return true;
    } catch (e) {
      dev.log(e.toString());
      return null;
      // dev.log(e.message ?? 'Error');
      // showSnackbar(context, e.message??'Error');
    }
  }

  /// Sign out
  Future signOut() async {
    try {
      await GoogleSignIn().signOut();
      return await _auth.signOut();
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }
}
