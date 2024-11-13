bool isEmailValid(String email) {
  // Regular expression for email validation
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  return emailRegex.hasMatch(email);
}

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1);
}
