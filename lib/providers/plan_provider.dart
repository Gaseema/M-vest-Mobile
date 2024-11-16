import 'package:invest/imports/imports.dart';

class Plan {
  final String name;
  final String type;
  final String maturityDate;
  final Map lock;
  final String createdAt;
  final num balance;
  final num target;

  Plan({
    required this.name,
    required this.type,
    required this.maturityDate,
    required this.lock,
    required this.createdAt,
    required this.balance,
    required this.target,
  });
}

class PlanProvider extends ChangeNotifier {
  List<Plan> _plans = [];

  List<Plan> get plans => _plans;

  void setPlans(List<Plan> plans) {
    _plans = plans;
    notifyListeners();
  }

  void addPlan(Plan plan) {
    _plans.add(plan);
    notifyListeners();
  }

  void removePlan(Plan plan) {
    _plans.remove(plan);
    notifyListeners();
  }
}
