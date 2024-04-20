import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String phoneNo;
  final String token;

  User({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.token,
  });
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;

    notifyListeners();
  }
}
