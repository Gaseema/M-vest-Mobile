import 'package:flutter/material.dart';

class UserTransactionsProvider extends ChangeNotifier {
  List userTransactions = [];

  void updateUserTransactions(List transactions) {
    userTransactions = transactions;
    notifyListeners();
  }
}
