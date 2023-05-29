// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ican/components/appBar.dart';
import 'package:ican/components/navBar.dart';
import 'package:ican/pages/targetInfo.dart';


class TargetsPage extends StatefulWidget {
  const TargetsPage({super.key});
  
  @override
  State<TargetsPage> createState() => _TargetsPageState();
}

@override
class _TargetsPageState extends State<TargetsPage> {
  TextEditingController idTarget = TextEditingController();
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: getTargetImage(docs),
                ),


      Column(
        children: [
          Text(
            docs['author'],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
            ),
          ),
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
                    onPressed: ()
                    {
                       Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TargetInfoPage(id: docs['id'])));},
                    child: const Text(
                      "Просмотреть",
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
        
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Targets").snapshots(), 
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