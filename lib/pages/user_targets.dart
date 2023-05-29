// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ican/components/appBar.dart';
import 'package:ican/components/navBar.dart';


class UserTarget extends StatefulWidget {
  const UserTarget({super.key});

  @override
  State<UserTarget> createState() => _TargetsPageState();
}

@override
class _TargetsPageState extends State<UserTarget> {
TextStyle CheckRating(rating){
    if (rating > 0){
      return TextStyle(
        color: Colors.red,
        fontSize: 20,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        fontFamily: 'Open Sans',
      );
    }
    if (rating < 0){
        return TextStyle(
          color: Color.fromARGB(255, 126, 53, 2),
          fontSize: 20,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontFamily: 'Open Sans',
          );
    }
    return TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontFamily: 'Open Sans',
          );
  }

  String CheckRatingonFire(rating){
     if (rating > 0){
      return '🔥';
    }
    if (rating < 0){
        return '💩';
    }
    return '🚬';
  }

 

  Image? getTargetImage(dynamic docs){
    if (docs['image'] != null){
      return 
      Image.network(
          docs['image'],
          width: 300,
          height: 200,
          fit: BoxFit.fill);
    }
    return null;  
  }


  Widget buildList(context, docs) {
        return  Card(
        elevation: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.black,
        child: Column(
          children: [
    
      // Column(
      //   children: [
      //     Text(
      //       docs['id'],
      //       style: const TextStyle(
      //         fontSize: 20,
      //         color: Color.fromARGB(255, 0, 0, 0),
      //         fontWeight: FontWeight.w900,
      //         fontStyle: FontStyle.italic,
      //         fontFamily: 'Open Sans',
      //       ),
      //     ),
      //   ],
      // ),
      Column(
        children: [
          Text(
            docs['title'],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
            ),
          ),
        ],
      ),
      Padding(
          padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () => ratingPlus(true, docs['id']),
                    child: const Text(
                      "Добился",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40,),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () => ratingPlus(false, docs['id']),
                    child: const Text(
                      "Не добился",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          )
        ]
      )
    );
  }
          void ratingPlus (bool isUp, String id) async {
            CollectionReference deals =  FirebaseFirestore.instance.collection('Users');
            var deal = await deals.doc(FirebaseAuth.instance.currentUser!.uid).get();
                      deals.doc(FirebaseAuth.instance.currentUser!.uid).update({
                      "rating":  isUp? deal['rating'] + 100 :deal['rating'] - 100});
            FirebaseFirestore.instance.collection('Targets').doc(id).delete();
            }
  
  @override
  Widget build(BuildContext context, ) {
        return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Targets').where('email' , isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
      builder:  (context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } 
        else {
          var list = snapshot.data.docs.toList();
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar(context),
                drawer: const NavBar(),
                body:
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) => buildList(
                        context,
                        list[index],
                      ),
                    )
              );
        }
      }
    );
  }
}
class Target{
  String author;
  String title;
  int rating;
  
  Target(this.author, this.title, this.rating);
}