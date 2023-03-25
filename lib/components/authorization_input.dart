import 'package:flutter/material.dart';

class AuthorizationInput extends StatelessWidget {
  static const double _widthScale = 0.8;
  final String labelText ;
  final Color color;
  final Icon icon;


  const AuthorizationInput({
    super.key,
    this.labelText = "Text",
    this.color = const Color.fromARGB(255, 255, 255, 255),
    this.icon = const Icon(
      Icons.abc,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * _widthScale,
      child: TextField(
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        cursorColor: color,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          label: Text(labelText),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: color,
            ),
          ),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
