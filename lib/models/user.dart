import 'package:cloud_firestore/cloud_firestore.dart';
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

    factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
    ) {
      final data = snapshot.data();
      return User(
        username: data?['username'],
        email: data?['email'],
        password: data?['password'],
        image: data?['image'],
        targets: data?['targets'],
      );
    }
  }
  