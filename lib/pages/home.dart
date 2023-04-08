// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ican/components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        title: Image.asset(
          'images/ICANicon.png',
          width: 180,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 40),
      ),
      drawer: MyDrawer(),
      body: Container(
          padding: EdgeInsets.only(top:20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Автор',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Цель',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Рейтинг',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Статус',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }
}
