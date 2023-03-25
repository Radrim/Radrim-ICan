import 'package:flutter/cupertino.dart';

class AuthorizationMargin extends StatelessWidget {
  final double heightScale;

  const AuthorizationMargin({super.key, this.heightScale = 0.02});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightScale,
    );
  }
}
