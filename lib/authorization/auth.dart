// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ican/authorization/service.dart';
import '../components/authorization_input.dart';
import '../components/margin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isRegister = false;
  final AuthServices _service = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    var user =
        await _service.signIn(_emailController.text, _passwordController.text);
        if (user != null){
          Navigator.popAndPushNamed(context, '/home');
        } 
        else {
          showDialog(
              context: context,
              builder: (context) {
              return const AlertDialog(
              content: Text('Wrong password or login'),
              );
            });
        }
  }

  Future signUp() async {
    var user = await _service.register(
        _emailController.text, _passwordController.text);
        if (user == null){
          showDialog(
              context: context,
              builder: (context) {
              return const AlertDialog(
              content: Text('Wrong data'),
              );
            });
        }
        else{
          showDialog(
              context: context,
              builder: (context) {
              return const AlertDialog(
              content: Text('Success'),
              );
            });
        }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
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
                _emailController,
                color: primaryColor,
                icon: Icon(Icons.email, color: iconColor),
                labelText: 'Email',
              ),
              const AuthorizationMargin(),
              AuthorizationInput(
                _passwordController,
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
                    _isRegister ? signUp() : signIn();
                  },
                  child: Text(_isRegister ? 'Register' : 'Sign in'),
                ),
              ),
              const AuthorizationMargin(),
              InkWell(
                child: Text(
                 _isRegister ? 'Sign in?' : "Sign up?",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                onTap: () => {
                  setState(() {
                    _isRegister = !_isRegister;
                },
              ),
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}