class Validation {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    if (!hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }

    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    if (!hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }

    final hasDigit = value.contains(RegExp(r'[0-9]'));
    if (!hasDigit) {
      return 'Password must contain at least one number';
    }

    final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (!hasSpecialChar) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^(01|\+201)\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number'; // Phone number must start with 01 or +201 and contain 8 digits after
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name must contain only alphabetic characters';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  static String? validateBirthDate(DateTime? date) {
    if (date == null) {
      return 'Birthdate is required';
    }

    if (date.isAfter(DateTime.now())) {
      return 'Birthdate cannot be in the future';
    }

    return null;
  }
}
