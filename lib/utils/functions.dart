import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/plans/new_plan.dart';
import 'package:invest/screens/dashboard/profile.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/utils/widgets.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:invest/providers/transaction_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:invest/widgets/currency_converter.dart';

fetchPlans(context) async {
  try {
    // Retrieve user information from provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token ?? '';
    ApiClient apiClient = ApiClient(token);
    var response = await apiClient.post('/plan/fetch/user_plans');
    return {'isSuccessful': true, 'data': response.data['plans']};
  } catch (e) {
    return {'isSuccessful': false, 'error': 'Error fetching plans'};
  }
}
