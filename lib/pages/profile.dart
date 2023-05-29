// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ican/components/appbar.dart';
import 'package:ican/components/navBar.dart';
import 'package:ican/pages/targets.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class Targets {
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
      RichText(
        text: TextSpan(
          style: TextStyle(
              color: Colors.white),
          children: [
            TextSpan(text: 'Рейтинг: ${docs['rating'].toString()} ',
              style: CheckRating(docs['rating'])),
            TextSpan(text: CheckRatingonFire(docs['rating']),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
              color: Colors.white,
              )
            ),
          ],
        ),
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
                    onPressed: () {},
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
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String? downloadUrl;

  Future pickImage() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pick != null) 
      {
        image = File(pick.path);
        uploadImage();
      }
      else 
      {
        return;
      }

    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Ошибка при выборе изображения: $e');
    }
  }

  Future uploadImage() async 
  {
    Reference ref = FirebaseStorage.instance.ref().child("profileImages/${FirebaseAuth.instance.currentUser?.uid}");
    await ref.putFile(image!);
    downloadUrl = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({'image': downloadUrl});

    print(downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    String? name;
    int? rating;
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Введите новое имя"),
                  content: TextFormField(
                    style: TextStyle(fontSize: 30),
                    initialValue: name,
                    onChanged: (String value) {
                      name = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({'username': name});
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text(
                          'Сохранить',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                );
              });
        },
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!
                    .uid) // 👈 Your document id change accordingly
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              Map<String, dynamic> data =
                  snapshot.data!.data()! as Map<String, dynamic>;

              name = data['username'];
              rating = data['rating'];
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                pickImage();
                              },
                              iconSize: 180,
                              icon: CircleAvatar(
                                radius: 180,
                                child: ClipOval(
                                  child: data['image'] == null ? Image.asset('images/Tyler.png',
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover) : Image.network(data['image'],
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover)),
                                ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 50, 0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',),
                      enabled: false,
                      initialValue: name,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Имя пользователя',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      enabled: false,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',),
                      initialValue: FirebaseAuth.instance.currentUser?.email,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0)),
                      children: [
                        TextSpan(text: 'Рейтинг: ${rating.toString()} ',
                          style: CheckRating(rating)),
                        TextSpan(text: CheckRatingonFire(rating),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                                color: const Color.fromARGB(255, 0, 0, 0),
                                )
                              ),
                            ],
                          ),
                        ),
                  ),
                ],
              );
            },
          ),
        ]
     )
    );
  }
  TextStyle CheckRating(int? rating){
    if (rating! > 0){
      return TextStyle(
        color: Colors.red,
        fontSize: 30,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        fontFamily: 'Open Sans',
      );
    }
    if (rating! < 0){
        return TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 30,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontFamily: 'Open Sans',
          );
    }
    return TextStyle(
          color: Color.fromARGB(255, 130, 144, 0),
          fontSize: 30,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontFamily: 'Open Sans',
          );
  }

  String CheckRatingonFire(int? rating){
     if (rating! > 0){
      return '🔥';
    }
    if (rating! < 0){
        return '💩';
    }
    return '🚬';
  }
}



