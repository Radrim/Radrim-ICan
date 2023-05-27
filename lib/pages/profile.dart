import 'package:flutter/material.dart';
import 'package:ican/NavBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(children: [
      ]
      ),
      
      );
    }
}

      