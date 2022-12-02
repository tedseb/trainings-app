import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:higym/app_utils/helper_utils.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/models/goal.dart';
import 'package:higym/services/database.dart';

import 'dart:developer' as dev;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FireBaseUser(after update => User)
  AppUser? _userFromFireBaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  /// Sign In With Google
  signInWithGoogle() async {
    /// Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }

    /// Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /// Once signed in, return the UserCredential
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      /// Check everything is ok and user is not null
      if (user != null) {
        if (result.additionalUserInfo!.isNewUser) {
          await user.delete();
          signOut();
          return 'You have to Register before you login with Google!';
        }
        return _userFromFireBaseUser(user);
      }
      return null;
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
        dev.log('Send Email Verification again!!!!');
        signOut();

        /// This causes "too many request if tried directly"
        user.sendEmailVerification();
        return 'Pleas Verify your Email at first!';
      }
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword({required String password, required AppUser onBoardingUser, required Goal onboardingGoal}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: onBoardingUser.email!.trim(), password: password);
      User? user = result.user;
      user!.sendEmailVerification();
      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).signUpNewUser(onBoardingUser);
      await DatabaseService(uid: user.uid).addGoal(onboardingGoal);
      signOut();
      return true;
      // return _userFromFireBaseUser(user);//this is no needed anymore
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Register with Google
  registerWithGoogle({required AppUser onBoardingUser, required Goal onboardingGoal}) async {
    /// Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /// Once signed in, return the UserCredential
    try {
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      /// Check everything is ok and user is not null
      if (user != null) {
        ///Only login and return User, if the User is a "NEW USER!!!"
        if (result.additionalUserInfo!.isNewUser) {
          onBoardingUser.email = user.email ?? 'user mail';
          //create a new document for the user with the uid
          await DatabaseService(uid: user.uid).signUpNewUser(onBoardingUser);
          await DatabaseService(uid: user.uid).addGoal(onboardingGoal);
          
          return _userFromFireBaseUser(user);
        }

        ///Return Error Text
        return null;
      }
      return null;
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

  Future deleteUser(BuildContext context) async {
    _auth.currentUser!.delete();
    // Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
