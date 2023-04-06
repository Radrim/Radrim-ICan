
import 'package:flutter/material.dart';
import 'package:ican/NavBar.dart';
import 'package:ican/scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color primaryColor = const Color.fromARGB(255, 255, 255, 255);
  Color secondaryColor = const Color.fromARGB(255, 0, 0, 0);
  int index = 0;
  String title = "Список дел";
  bool isDefaultAppBar = true;
  String searchText = "";

  TextEditingController searchController = TextEditingController();

  Widget getCurrentPage(int index) {
    final listPages = [
      const CardPage(),
    ];

    return listPages[index];
  }

  AppBar getDefaultAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              searchController.clear();
              isDefaultAppBar = !isDefaultAppBar;
            });
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black),
        )
      ],
      title: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
        decoration: const InputDecoration(label: Text('Название')),
      ),
    );
  }

  AppBar getSearchAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isDefaultAppBar = !isDefaultAppBar;
            });
          },
          icon: const Icon(
            color: Colors.black,
            Icons.search,
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDefaultAppBar
          ? getSearchAppBar(context)
          : getDefaultAppBar(context),
      body: Container(
        child: getCurrentPage(index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const NavBar(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
