import 'dart:typed_data';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class authMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign Up

  Future<model.User> getdetails() async {
    User currentuser = _auth.currentUser!;
    //this is returning the value from user model class where there is a fucntion called fromsnap//
    DocumentSnapshot snap =
        await _firestore.collection("Users").doc(currentuser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signupUser({
    required String email,
    required String passwords,
    required String username,
    required String bio,
    required Uint8List File,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
          passwords.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          File != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: passwords);

        String photourl = await StorageMethods()
            .uploadImageToStorage("Profilepics", File, false);
        //add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          followers: [],
          following: [],
          email: email,
          photourl: photourl,
        );
        await _firestore.collection("Users").doc(cred.user!.uid).set(
              user.toJson(),
            );
        print(res);
        res = "sucess";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "email is not in proper format";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login methods
  Future<String> LoginMethod({
    required String email,
    required String password,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "sucess";
      } else {
        res = "please enter all the fields";
      }
    }
    //  on FirebaseAuthException catch(e){
    //   if (e.code=="user-not-found") {

    //  } }

    catch (e) {
      res = e.toString();
    }
    return res;
  }
}
