import 'package:invest/imports/imports.dart';

class UserTransactionsProvider extends ChangeNotifier {
  List userTransactions = [];

  void updateUserTransactions(List transactions) {
    userTransactions = transactions;
    notifyListeners();
  }
}
