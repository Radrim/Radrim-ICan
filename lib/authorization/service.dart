import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'model.dart';
import 'package:flutter/cupertino.dart';



class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<UserModel?> get currentUser {
    return _firebaseAuth.authStateChanges().map(
        (User? user) => user != null ? UserModel.fromFirebase(user) : null);
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      if (user == null) {
        return null;
      }

      return UserModel.fromFirebase(user);

    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> register(String email, String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      if (user == null) {
        return null;
      }

      return UserModel.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future saveUserToDb(BuildContext context, String username, String email, String password) async
  {
    try{
      //CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      var firebaseUser =  FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection("Users").doc(firebaseUser?.uid).set({
          'username': username,
          'email': email,
      });
    }
    catch (e) 
    {
      return;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }
}