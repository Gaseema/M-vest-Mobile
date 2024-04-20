class InputValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    // Email regex pattern
    // const pattern =
    //     r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$';
    // final regExp = RegExp(pattern);
    // if (!regExp.hasMatch(email)) {
    //   return 'Invalid email address';
    // }

    return null;
  }

  static String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    // Phone number regex pattern
    // const pattern = r'^\d{10}$'; // 10-digit phone number pattern
    // final regExp = RegExp(pattern);
    // if (!regExp.hasMatch(phoneNumber)) {
    //   return 'Invalid phone number';
    // }
    return null;
  }

  static String? validateFullName(String fullName) {
    if (fullName.isEmpty) {
      return 'Full name is required';
    }
    // Full name should have at least two names
    final nameList = fullName.trim().split(' ');
    if (nameList.length < 2) {
      return 'Invalid full name, please enter two names';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    // Password validation criteria
    if (password.length < 8) {
      return 'Password must have at least 8 characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain a lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain a special character';
    }
    return null;
  }
}
