import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ican/components/appbar.dart';
import 'dart:io';
import 'package:ican/components/target_service.dart';
import 'package:ican/pages/targets.dart';
import 'package:image_picker/image_picker.dart';

class CreateTargetPage extends StatefulWidget {
  @override
  State<CreateTargetPage> createState() => Create();
}

class Create extends State<CreateTargetPage> {
  final TargetService _targetService = TargetService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? image;
  String? downloadUrl;
  ImagePicker imagePicker = ImagePicker();
 
  void showSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value),
        backgroundColor: Colors.primaries.first,));
  }


  Future pickImage() async {
    try {
      final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pick != null) 
      {
        image = File(pick.path);
      }
      else 
      {
        return;
      }

    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Ошибка при выборе изображения: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
  
final Stream<DocumentSnapshot<Map<String,dynamic>>> _stream = FirebaseFirestore
                   .instance
                   .collection('Users')
                   .doc(FirebaseAuth.instance.currentUser!.uid) // 👈 Your document id change accordingly
                   .snapshots();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: buildAppBar(context),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _stream, 
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              
            }
            if (!snapshot.hasData){
              return const Text('Nothing was found');
            }
          Map<String, dynamic> data = snapshot.data!.data()! as Map<String, dynamic>;  
          return Stack(children: <Widget>[
            Container(height: 80),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    autofocus: true,
                    controller: _titleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 200,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Название вашей цели',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 600,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Описание цели',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () => pickImage(),
                  child: Text('Выбрать изображение')
                  ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () => {
                    _targetService.createTarget(context, _titleController.text, _descriptionController.text, data['username'], image),
                    showDialog(context: context, 
                    builder: (BuildContext context) 
                    {
                      return const AlertDialog(title: Text('Цель успешно создана'),);
                    })
                    },
                
                    
                  child: Text('Создать цель'),
                )
              ],
            ),
          ]);
          } 
          ,
        ),
      )
    )
    )
    ; 
  }
}