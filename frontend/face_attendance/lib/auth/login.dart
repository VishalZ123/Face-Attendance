// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visibility = true; // visibilty value for the password field
  toggle() { // function to toggle the visibility of the password field
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Log In'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 100),
                        elevation: 2.0,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: 360.00,
                          height: 300.00,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.mail,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter email",
                                      hintStyle: TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          fontSize: 18.0)),
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  obscureText: visibility,
                                  controller: passwordController,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter password",
                                      hintStyle: const TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          fontSize: 18.0),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          toggle();
                                        },
                                        child: Icon( // change the icon based on the visibility value
                                          visibility
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20.0,
                                          color: Colors.black,
                                        ),
                                      )),
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 40.0),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 42.0),
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          color: Colors.white,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    String role = await login(
                                        emailController.text,
                                        passwordController.text,
                                        context);
                                    if (role == 'Student') {
                                      Navigator.pushNamed(context, '/student'); // redirect to teacher dashboard
                                    } else if (role == 'Teacher') {
                                      Navigator.pushNamed(context, '/teacher'); // redirect to teacher dashboard
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AlertDialog( // alert if the credentials are incorrect
                                                title: const Text("Error",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    )),
                                                content: const Text(
                                                    "Invalid email or password"),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text("Close"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

String url = 'https://face-attendance-msengage.herokuapp.com/users/login/';
// ignore: prefer_typing_uninitialized_variables
var response;
Future login(email, password, context) async {
  try {
    response = await http.get(Uri.parse(url), headers: { // send a http request with email and password in headers
      "email": email,
      "password": password,
    });
    Map<String, dynamic> data = jsonDecode(response.body); // decode the response
    if (response.statusCode == 200) {

      // at the time of login store the token, role, username and email in flutter storage for future use
      String token = data["token"];
      FlutterStorage.writeVal('token', token);

      String role = data["role"];
      FlutterStorage.writeVal('role', role);

      String username = data["username"];
      FlutterStorage.writeVal('username', username);

      String email = data["data"]["email"];
      FlutterStorage.writeVal('email', email);

      return role;
    } else {
      return 'error';
    }
  } catch (e) {
    // for unseen errors (should not occur according to the backend)
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Something went wrong, Try logging in again',
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    ));
    return 'error';
  }
}
