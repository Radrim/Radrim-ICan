import 'package:flutter/material.dart';
import '../NavBar.dart';

class TargetInfoPage extends StatefulWidget {
  const TargetInfoPage({super.key});

  @override
  State<TargetInfoPage> createState() => _TargetInfoPage();
}

class _TargetInfoPage extends State<TargetInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          centerTitle: true,
          title: Image.asset('images/ICANicon.png', width: 180)),
      drawer: const NavBar(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Center(
            child: Padding( 
              padding: EdgeInsets.only(top: 10.0),
              child: const Text('Цель',
                style: TextStyle(
                  fontSize: 40,
                )),),
          ),

          
        ],
      ),
    );
  }
}
