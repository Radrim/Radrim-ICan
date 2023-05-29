import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:xid/xid.dart';

class ImageService
{
  final _storageRef = FirebaseStorage.instance.ref();

  Future<String?> uploadTargetImage(File file) async
  {
    var xid = Xid();
    
    try {
      var imgfile = _storageRef.child("/${xid.toString()}.jpg");

      UploadTask task = imgfile.putFile(file);
      TaskSnapshot snapshot = await task;

      var url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return 'null';
    }
  }
}