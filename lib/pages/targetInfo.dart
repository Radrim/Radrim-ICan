// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ican/components/appbar.dart';
import 'package:ican/components/navBar.dart';

class TargetInfoPage extends StatefulWidget {
  const TargetInfoPage({super.key});

  @override
  State<TargetInfoPage> createState() => _TargetInfoPage();
}

class _TargetInfoPage extends State<TargetInfoPage> {
  List<String> _comments = [
    'Прекрасная цель!',
    'Очень интересная цель',
    'Надеюсь ты сможешь',
  ];

  void _addComment(String comment) async {
    setState(() {
      _comments.add(comment);
    });
  }

  final Stream<DocumentSnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('Targets')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: _usersStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Что-то пошло не так");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              Map<String, dynamic> data =
                  snapshot.data!.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        'Цель',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: data['image'] == null
                                  ? Image.asset('images/Tyler.png',
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover)
                                  : Image.network(data['image'],
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover)),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 180,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Автор: ${data['author']}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Цель: ${data['title']}",
                                style: TextStyle(fontSize: 25),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Описание: ${data['description']}",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      'Добавить комментарий',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Введите комментарий',
                      ),
                      onFieldSubmitted: (value) async {
                        _addComment(value);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(children: [
                      Text(
                        "Комментарии:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 480,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _comments
                                  .map((comment) => Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          comment,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
