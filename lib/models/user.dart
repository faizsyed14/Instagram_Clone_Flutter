import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  const User({
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photourl,
    required this.uid,
    required this.username,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "bio": bio,
        "followers": followers,
        "following": following,
        "email": email,
        "photourl": photourl,
      };
  static User fromSnap(DocumentSnapshot snap) {
    //importing documentSnapshot from cloud_firestore
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot["email"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      photourl: snapshot["photourl"],
      uid: snapshot["uid"],
      username: snapshot["username"],
    );
  }
}
