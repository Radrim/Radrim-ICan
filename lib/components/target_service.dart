import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ican/components/image_service.dart'; 

class TargetService
{
  //final ImageService _imgService = ImageService();
  final allPostsStream = FirebaseDatabase.instance.ref('post').onValue;


  createTarget(BuildContext context, String title, String description, String username, File? img) async
  {  
    Reference ref = FirebaseStorage.instance.ref().child("targetImages/${FirebaseAuth.instance.currentUser?.uid}");
    await ref.putFile(img!);
    String downloadUrl = await ref.getDownloadURL();

    var firebaseUser =  FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection("Targets").doc(firebaseUser?.uid).set({
    'title': title,
    'description': description,
    'image': downloadUrl,
    'author': username,
    });



  }

  // Future<void> sendComment(BuildContext context, Post post, String text) async
  // {
  //   try {
  //     post.comments ??= [];

  //     var userId = Provider.of<UserModel?>(context, listen: false)!.id;
      
  //     post.comments!.add(Comment(userId, text, DateTime.now()));

  //     var postsRef = _dbRef.child('post');

  //     if(post.comments!.isEmpty)
  //     {
  //       postsRef.child(post.id!).child('comments').set("null");
  //     }
  //     else{
  //       var newKey = postsRef.child(post.id!).child('comments').push();
  //       var keyValue = newKey.key.toString();
  //       var comment = postsRef.child(post.id!).child('comments').child(keyValue);

  //       comment.child('username').set(userId);
  //       comment.child('text').set(post.comments!.last.text);
  //       comment.child('createdDate').set(post.comments!.last.createdDate.toString());
  //     }
  //   } on Exception catch(e) {return;}
  // }
}
