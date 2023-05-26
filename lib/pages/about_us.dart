// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ican/NavBar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

 @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        title: Image.asset(
          'images/ICANicon.png',
          width: 180
        )
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[  
              Expanded(
                child: Column(
                  children:[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                      Text(
                        'О нас.', 
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      )
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                      Text(
                        'ICAN - приложение, в котором люди ставлят себе цели и выполняют их.', 
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ) 
                      ),
                    ), 
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                      Text(
                        'ICAN - место, где такие же целеустремленные люди тебя поддержат', 
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ) 
                      ),
                    ), 
                    SizedBox(height: 30), 
                    Text(
                      'Ставь цели. Ставь задачи. Выполняй.', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 180,
                          top: 20,
                          right: 40,
                          bottom: 20,
                        ),
                      child:
                      Image(
                        width: 150,
                        height: 250,
                        image: AssetImage("images/Tyler.png"),
                        alignment: Alignment.bottomRight,
                        ),
                      ),
                    ],
                ),
              ),
            ]
          ),
        ]
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    drawer: const NavBar(),
    backgroundColor: Colors.white,
    );
  }
}