import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginPageBloc with ChangeNotifier {
  bool isLoginPressed = false;

  String? validateEmail(String? email) {
    if (email!.isEmpty && EmailValidator.validate(email)) {
      return 'please enater valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty && password.length < 8) {
      return 'password must be at least 8 characters';
    }
    return null;
  }

  Future<void> validateFormAndLogin(
      GlobalKey<FormState> formKey, String userName, String password) async {
    isLoginPressed = true;
    notifyListeners();
    // if (formKey.currentState!.validate()) {
    //   await _authMethods.handleSignInEmail(userName, password);
    //   isLoginPressed = false;
    //   notifyListeners();
    // }
  }
}
