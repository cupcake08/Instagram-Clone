import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import '../models/user.dart' as model;

class UserProvider with ChangeNotifier {
  model.User? _user;

  final AuthMethods _authMethods = AuthMethods();

  model.User get getUser => _user!;

  Future<void> refreshUser() async {
    model.User user = await _authMethods.getUser();
    _user = user;
    notifyListeners();
  }
}
