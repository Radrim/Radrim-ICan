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
            accountName: Text(
              data['username'],
              style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Open Sans',
                        ),),
            accountEmail: Text('${user?.email}',
            style: const TextStyle(
                          color: Color.fromARGB(255, 209, 209, 209),
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Open Sans',
                        ),),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child:data['image'] == null ? Image.asset('images/Tyler.png',
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.cover) : Image.network(data['image'],
                                      height: 90,
                                      width: 90,
                                      fit: BoxFit.cover),
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
            leading: const Icon(Icons.vertical_align_center),
            title: const Text('Добавить цель'),
            onTap: () => Navigator.popAndPushNamed(context, '/createTarget'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Мои цели'),
            onTap: () => Navigator.popAndPushNamed(context, '/userTargets'),
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