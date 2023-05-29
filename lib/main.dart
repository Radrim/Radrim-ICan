import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ican/authorization/auth.dart';
import 'package:ican/pages/about_us.dart';
import 'package:ican/pages/add_target.dart';
import 'package:ican/pages/profile.dart';
import 'package:ican/pages/targetInfo.dart';
import 'package:ican/pages/targets.dart';

import 'pages/user_targets.dart';

void main() async {
  // DBConnection().connectDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyThemeApp());
}

class MyThemeApp extends StatelessWidget {
  const MyThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0)),
      // home: AuthPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/home': (context) => const TargetsPage(),
        '/aboutUs': (context) => const AboutUsPage(),
        '/auth' : (context) => const AuthPage(),
        '/createTarget' : (context) => CreateTargetPage(),
        '/profile' : (context) => const ProfilePage(),
        '/userTargets' : (context) => const UserTarget(),
        '/targetInfo' : (context) =>  const TargetInfoPage(id: null)
      },
    );
  }
}
