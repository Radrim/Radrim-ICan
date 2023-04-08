import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black45,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/ICANicon.png'),
                        radius: 40,
                      ),
                      Text(
                        'Your name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Главная',
                style: TextStyle(color: Colors.white, fontSize: 24,),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: Text(
                'Профиль',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star_rate,
                color: Colors.white,
              ),
              title: Text(
                'Рейтинг',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              title: Text(
                'О нас',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            )
          ],
        ),
      );
  }
}