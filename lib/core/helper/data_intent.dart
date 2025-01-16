class DataIntent {
  DataIntent._();

  //login
  static String? _email;

  static void pushEmail(String email) => _email = email;

  static String? popEmail() => _email;
  static String? _password;

  static void pushPassword(String password) => _password = password;

  static String? popPassword() => _password;
}
