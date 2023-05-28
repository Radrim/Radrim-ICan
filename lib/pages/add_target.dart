/*
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'targets.dart';

class AddDeal extends StatefulWidget {
  Target target;
  String title;
  bool isEdit;

  AddDeal(this.title, this.deal, this.isEdit, {super.key});

  @override
  State<AddDeal> createState() => _AddDealState();
}

class _AddDealState extends State<AddDeal> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool imageTwest() {
      bool image = false;
      if (widget.deal.image == null) {
        image = true;
      } 
      else {
        image = false;
      }
      return image;
    }

    if (widget.deal != null &&
        (widget.deal.title != null ||
            widget.deal.description != null ||
            widget.deal.image != null)) {
      titleController.text = widget.deal.title.toString();
      descriptionController.text = widget.deal.description.toString();
      imageController.text = widget.deal.image.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 227, 206, 17),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Visibility(
                visible: widget.deal.image != "",
                child: Image.network(widget.deal.image),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Title"),
                  labelStyle: const TextStyle(color: Color(0xFFFFDF4A)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                ),
                controller: titleController,
                cursorColor: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Description"),
                  labelStyle: const TextStyle(color: Color(0xFFFFDF4A)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                ),
                controller: descriptionController,
                cursorColor: Colors.amber,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("Image"),
                  labelStyle: const TextStyle(color: Color(0xFFFFDF4A)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFFFDF4A)),
                  ),
                ),
                controller: imageController,
                cursorColor: Colors.amber,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Visibility(
                  visible: !widget.isEdit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: ElevatedButton(
                            onPressed: () async {
                              widget.deal.title = titleController.text;
                              widget.deal.description =
                                  descriptionController.text;
                              widget.deal.image = imageController.text;

                              CollectionReference deals = FirebaseFirestore
                                  .instance
                                  .collection('deals');

                              await deals.add({
                                'title': widget.deal.title,
                                'description': widget.deal.description,
                                'image': widget.deal.image,
                              });

                              titleController.clear();
                              descriptionController.clear();
                              imageController.clear();
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Добавить"),
                                Icon(Icons.add)
                              ],
                            ),
                          )),
                    ],
                  )),
              Visibility(
                  visible: widget.isEdit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 227, 206, 17)
                          ),
                          onPressed: () async {
                            CollectionReference deals =
                                FirebaseFirestore.instance.collection('deals');
                            await deals.doc(widget.deal.id).delete();
                            titleController.clear();
                            descriptionController.clear();
                            imageController.clear();
                            Navigator.pop(context);
                          },
                          child: Row(children: const [
                            Text("Удалить"),
                            Icon(Icons.delete)
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 227, 206, 17)
                          ),
                          onPressed: () async {
                            CollectionReference deals =
                                FirebaseFirestore.instance.collection('deals');
                            await deals.doc(widget.deal.id).update({
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "image": imageController.text,
                            });
                            titleController.clear();
                            descriptionController.clear();
                            imageController.clear();
                            Navigator.pop(context);
                          },
                          child: Row(children: const [
                            Text("Обновить"),
                            Icon(Icons.update)
                          ]),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
  }
}
*/