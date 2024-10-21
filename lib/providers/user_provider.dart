import 'package:invest/imports/imports.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String token;

  User({
    required this.firstName,
    required this.lastName,
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

void updateUserProvider(
  UserProvider userProvider,
  Map<String, dynamic> userData,
) {
  // Update the userProvider with the new user data
  userProvider.setUser(
    User(
      firstName: userData['user']['first_name'],
      lastName: userData['user']['last_name'],
      email: userData['user']['email'].replaceAll(' ', ''),
      phoneNo: userData['user']['phone_number'],
      token: userData['token'],
    ),
  );
}
