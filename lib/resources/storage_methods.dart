import 'dart:typed_data';

import "package:uuid/uuid.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //tryingg to understand
  ///
////// ///
/////
////
  ///
  Future<String> uploadImageToStorage(
      String Childname, Uint8List file, bool ispost) async {
    Reference ref =
        _storage.ref().child(Childname).child(_auth.currentUser!.uid);
    if (ispost) {
      //for post id to to be unique because id will be same for same user and user will post multiple post
      // ,so in one uuiid it is storing our post//
      String id = Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}
