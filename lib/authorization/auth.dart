import 'package:flutter/material.dart';
import '../components/authorization_input.dart';
import '../components/margin.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color.fromARGB(255, 255, 255, 255);
    var iconColor = const Color.fromARGB(255, 255, 0, 0);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40.0),
                height: 100.0,
                width: 300.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/ICANicon.png'),
                  fit: BoxFit.fill,),
                  shape: BoxShape.rectangle,
                ),
              ),
              const AuthorizationMargin(
                heightScale: 0.05,
              ),
              AuthorizationInput(
                color: primaryColor,
                icon: Icon(Icons.email, color: iconColor),
                labelText: 'Email',
              ),
              const AuthorizationMargin(),
              AuthorizationInput(
                color: primaryColor,
                icon: Icon(Icons.email, color: iconColor),
                labelText: 'Password',
              ),
              const AuthorizationMargin(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(iconColor),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/home');
                  },
                  child: const Text('Sign in'),
                ),
              ),
              const AuthorizationMargin(),
              InkWell(
                child: Text(
                  "Sign up?",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                onTap: () => {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
