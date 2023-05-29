

import 'package:cloud_firestore/cloud_firestore.dart';

class Target
{
    String? id;
    String? author;
    String? title;
    List<String>? likesCount;
    List<String>? dislikesCount;
    String? targetImage;
    String? description;

    Target(
    {
      this.id,
      this.author,
      this.title,
      this.likesCount,
      this.dislikesCount,
      this.targetImage,
      this.description,
    }
    );

  // factory Target.fromMap(Map<dynamic, dynamic> map) {
  //   List<String> likes = [];
  //   List<String> dislikes = [];

  //   if (map['likes'] != "null" && map['likes'] != null)
  //   {
  //     map['likes'].forEach((obj) {likes.add(obj.toString());});
  //   }

  //   if (map['dislikes'] != "null" && map['dislikes'] != null)
  //   {
  //     map['dislikes'].forEach((obj) {dislikes.add(obj.toString());});
  //   }

  //   return Target(
  //     id: map['id'] ?? '',
  //     author: map['author'] ?? '',
  //     title: map['title'] ?? '',
  //     description: map['description'] ?? '',
  //     targetImage: map['targetImage'] ?? 'null',
  //     likesCount: map['likes'] == "null" || map['likes'] == null ? null : likes,
  //     dislikesCount: map['dislikes'] == "null" || map['dislikes'] == null ? null : dislikes,
  //   );
  // }
}