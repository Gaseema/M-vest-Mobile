import 'package:invest/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:invest/utils/api.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> handleBiometricAuthentication() async {
  try {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = await auth.canCheckBiometrics;

    if (!canCheckBiometrics) {
      return {
        'isSuccessful': false,
        'error': 'Biometric authentication not available'
      };
    }

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      return {'isSuccessful': false, 'error': 'No biometric sensors available'};
    }

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userEmail = prefs.getString('email');
    // String? userPassword = prefs.getString('password');

    // if (userEmail == null ||
    //     userEmail.isEmpty ||
    //     userPassword == null ||
    //     userPassword.isEmpty) {
    //   return {
    //     'isSuccessful': false,
    //     'error':
    //         'Please log in using your credentials to activate biometric authentication'
    //   };
    // }

    bool authenticated = await auth.authenticate(
      localizedReason: 'Please authenticate to proceed',
    );

    if (authenticated) {
      return {'isSuccessful': true};
    } else {
      return {'isSuccessful': false, 'error': 'Authentication failed'};
    }
  } on PlatformException catch (e) {
    print('Biometric authentication error: $e');
    return {
      'isSuccessful': false,
      'error': 'Biometric authentication error: $e'
    };
  }
}

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
