// ignore_for_file: avoid_returning_null_for_void, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ican/authorization/auth.dart';
import 'package:ican/authorization/service.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final authService = AuthServices();

    return Drawer(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream:  FirebaseFirestore
                   .instance
                   .collection('Users')
                   .doc(FirebaseAuth.instance.currentUser!.uid) // 👈 Your document id change accordingly
                   .snapshots(), 
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            Map<String, dynamic> data = snapshot.data!.data()! as Map<String, dynamic>; 
          return ListView(
          padding: EdgeInsets.zero,
          children: [
          UserAccountsDrawerHeader(
            accountName: Text(data['username']),
            accountEmail: Text('${user?.email}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network('https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),                
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Главная'),
            onTap: () => Navigator.popAndPushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Профиль'),
            onTap: () => Navigator.popAndPushNamed(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('О нас'),
            onTap: () => Navigator.popAndPushNamed(context, '/aboutUs'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Выйти'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => {
              authService.logOut(),
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const AuthPage()),
                          (Route<dynamic> route) => false,)
                          }
          ),
        ],
      );
        },
      )
    );
  }
}