class Validator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value,{bool isSignUp = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if(isSignUp){
      if (value.length < 8) {
        return 'Password must be at least 8 characters long';
      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
        return 'Password must contain at least one letter and one number';
      }
    }
    return null;
  }
}
