import 'package:book_library/screens/overview.dart';
import 'package:book_library/utils/account_helper.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<StatefulWidget> createState() {
    return RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  bool passwordVisible = false;
  AccountHelper helper = AccountHelper();

  RegisterViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400.0,
          height: 600.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text('Register', style: TextStyle(fontSize: 35))),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.red[900],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.red[900],
                  ),
                  errorText: _errorPassword(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: rePasswordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password again',
                  labelStyle: TextStyle(
                    color: Colors.red[900],
                  ),
                  errorText: _errorRePassword(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 150, 0, 0), width: 0.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            // Save & Delete
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  // Delete
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 150, 0, 0),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                          textScaler: TextScaler.linear(1.5),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _register();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        tooltip: 'Return to Login',
        child: const Text('x'),
      ),
    );
  }

  String? _errorRePassword() {
    return passwordController.text == rePasswordController.text
        ? null
        : 'Passwords are not the same';
  }

  String? _errorPassword() {
    String password = passwordController.text;
    bool isComplient = false;
    bool hasDigits = false;
    bool hasLowercase = false;
    bool hasUppercase = false;
    bool hasSpecialCharacters = false;
    bool isLong = passwordController.text.length >= 14;

    var character = '';
    if (password.isEmpty) {}
    hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    for (int i = 0; i < password.length; i++) {
      character = password.substring(i, i + 1);

      if (_isDigit(character, 0)) {
        hasDigits = true;
      } else {
        if (character == character.toUpperCase()) {
          hasUppercase = true;
        }
        if (character == character.toLowerCase()) {
          hasLowercase = true;
        }
      }
    }
    isComplient =
        hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & isLong;
    return isComplient
        ? null
        : 'The Password needs: ${hasDigits ? '' : 'a digit, '}${hasLowercase ? '' : 'a lowercase letter, '}${hasUppercase ? '' : 'a uppercase letter, '}${hasSpecialCharacters ? '' : 'a special character, '}${isLong ? '' : '14 letters, '}';
  } // TODO: Fix textbreak, fix trailling comma

  bool _isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

  void _register() async {
    if (nameController.text == '') {
      _showAlertDialog('Register', 'You need to set a username.');
      return;
    }
    if (_errorPassword() != null) {
      _showAlertDialog('Register', 'Your password is not safe enough.');
      return;
    }
    if (_errorRePassword() != null) {
      _showAlertDialog('Register', 'Your passwords don\'t match.');
      return;
    }
    if (await helper.isNameUsed(nameController.text)) {
      _showAlertDialog('Register', 'The username is already used.');
      return;
    }
    if (await helper.insertAccount(
            nameController.text, passwordController.text) ==
        0) {
      _showAlertDialog('Register', 'Account not Created.');
      return;
    }
    Navigator.pop(context, true);
    _showAlertDialog('Register', 'Account successfully Created.');
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
