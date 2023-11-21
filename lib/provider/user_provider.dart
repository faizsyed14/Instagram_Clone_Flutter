import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final authMethods _authmethods = authMethods();
  User get getUser => _user!;
  //this function updates the user also changes when refreshes
  Future<void> refreshUser() async {
    User user = await _authmethods.getdetails();

    _user = user;

    notifyListeners();
  }
}
