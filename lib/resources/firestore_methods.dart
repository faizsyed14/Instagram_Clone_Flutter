import 'package:uuid/uuid.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";
import "package:instagram_clone/models/post.dart";
import "package:instagram_clone/resources/storage_methods.dart";

class FireStoremethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //upload post
  Future<String> uploadpost(String description, Uint8List file, String uid,
      String username, String profileimage) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postid = Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postid: postid,
        datepublished: DateTime.now(),
        posturl: photoUrl,
        postimage: profileimage,
        likes: [],
      );
      _fireStore.collection("posts").doc(postid).set(
            post.toJson(),
          );
      res = "sucess";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likespost(String postId, String uid, List likes) async {
    try {
      //for adding the uid in array in the likes[] database
      if (likes.contains(uid)) {
        await _fireStore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _fireStore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> postcomments(String postId, String text, String uid, String name,
      String profilepic) async {
    try {
      if (text.isNotEmpty) {
        String commentid = const Uuid().v1();
        await _fireStore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentid)
            .set({
          "profilepic": profilepic,
          "name": name,
          "text": text,
          "commentid": commentid,
          "datepublished": DateTime.now()
        });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting the post
  Future<void> deletepost(String postid) async {
    try {
      _fireStore.collection("posts").doc(postid).delete();
    } catch (e) {
      print(e.toString());
    }
  }

//have to understand
  Future<void> followuser(
    String uid,
    String followid,
  ) async {
    DocumentSnapshot snap = await _fireStore.collection("Users").doc(uid).get();
    List following = (snap.data()! as dynamic)["following"];
    if (following.contains(followid)) {
      await _fireStore.collection("Users").doc(followid).update({
        "followers": FieldValue.arrayRemove([uid]),
      });
      await _fireStore.collection("Users").doc(uid).update({
        "following": FieldValue.arrayRemove([followid]),
      });
    } else {
      await _fireStore.collection("Users").doc(followid).update({
        "followers": FieldValue.arrayUnion([uid]),
      });
      await _fireStore.collection("Users").doc(uid).update({
        "following": FieldValue.arrayUnion([followid]),
      });
    }
  }
}
