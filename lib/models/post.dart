import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postid;
  final datepublished;
  final String posturl;
  final String postimage;
  final likes;
  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postid,
      required this.datepublished,
      required this.posturl,
      required this.postimage,
      required this.likes});
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postid": postid,
        "datepublished": datepublished,
        "posturl": posturl,
        "postimage": postimage,
        "likes": likes,
      };
  static Post fromSnap(DocumentSnapshot snap) {
    //importing documentSnapshot from cloud_firestore
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        username: snapshot["username"],
        uid: snapshot["uid"],
        description: snapshot["description"],
        datepublished: snapshot["datepublished"],
        posturl: snapshot["posturl"],
        postimage: snapshot["postimage"],
        likes: snapshot["likes"],
        postid: snapshot["postid"]);
  }
}
