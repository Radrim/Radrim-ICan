import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        title: Image.asset(
          'images/ICANicon.png',
          width: 180
        )
      );
}