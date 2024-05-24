import 'package:flutter/material.dart';

class Plan {
  final String name;
  final String email;
  final String phoneNo;
  final String token;

  Plan({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.token,
  });
}

class PlanProvider extends ChangeNotifier {
  Plan? _plan;

  Plan? get user => _plan;

  void setUser(Plan plan) {
    _plan = plan;

    notifyListeners();
  }
}
