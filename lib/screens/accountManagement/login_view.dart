import 'package:book_library/screens/accountManagement/register_view.dart';
import 'package:book_library/screens/overview.dart';
import 'package:book_library/utils/account_helper.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  AccountHelper helper = AccountHelper();

  LoginViewState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400.0,
          height: 600.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 35),
                ),
              ),
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
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    // Save
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 150, 0, 0),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                            textScaler: TextScaler.linear(1.5),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _login();
                              },
                            );
                          },
                        ),
                      ),
                    ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterView();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (!await helper.checkLogin(
        nameController.text, passwordController.text)) {
      _showAlertDialog('Login', 'Wrong Login Data');
      return;
    }
    nameController.text = '';
    passwordController.text = '';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OverView(path: helper.path),
      ),
    );
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
