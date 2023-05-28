import 'package:ican/models/target.dart';

class User 
{
  String? username;
  String? email;
  String? password;
  String? image;
  List<Target>? targets;

  User(
    {
      this.username,
      this.email,
      this.password,
      this.image,
      this.targets,
    });

     Map<String, Object> toMap() {
    return {
      'Username': username!,
      'Email': email!,
      'Password': password!,
      'Image': image!,
      'Targets': targets!,
    };
  }

  static User? fromMap(Map<dynamic, dynamic>? value) {
    if (value == null) {
      return null;
    }
    List<Target> targets = [];

    if (value['targets'] != null)
    {
      (value['targets']).forEach((targets) {
        targets.add(int.parse(targets.toString()));
      });
    }

    return User(
      username: value['username'],
      email: value['email'],
      password: value['password'],
      image: value['image'],
      targets: targets,
    );
  }

  @override
  String toString() {
    return ('{Username: $username, Email: $email, Password: $password}');
  }
}