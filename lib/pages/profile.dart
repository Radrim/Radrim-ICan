import 'package:flutter/material.dart';
import 'package:ican/NavBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const NavBar(),
    );
  }
}