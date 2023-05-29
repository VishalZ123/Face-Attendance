// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:face_attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../storage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  List<bool> isSelected = [false, false]; // for radio button
  bool visibility1 = true;
  bool visibility2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
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
                        elevation: 2.0,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: SizedBox(
                          width: 360.00,
                          height: 560.00,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter name",
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
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: ToggleButtons(
                                  borderRadius: BorderRadius.circular(8.0),
                                  fillColor: Colors.blue,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: isSelected,
                                  children: const <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            left: 25.0,
                                            right: 25.0),
                                        child: Text(
                                          "Teacher",
                                          style: TextStyle(
                                              fontFamily: "SignikaSemiBold",
                                              color: Colors.black,
                                              fontSize: 22.0),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            left: 25.0,
                                            right: 25.0),
                                        child: Text(
                                          "Student",
                                          style: TextStyle(
                                              fontFamily: "SignikaSemiBold",
                                              color: Colors.black,
                                              fontSize: 22.0),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  obscureText: visibility1,
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
                                        setState(() {
                                          visibility1 = !visibility1;
                                        });
                                      },
                                      child: Icon(
                                        visibility1
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextField(
                                  obscureText: visibility2,
                                  controller: confirmPasswordController,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: const Icon(
                                        Icons.password,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Confirm password",
                                      hintStyle: const TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          fontSize: 18.0),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            visibility2 = !visibility2;
                                          });
                                        },
                                        child: Icon(
                                          visibility2
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                          size: 22.0,
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
                                      "Sign Up",
                                      style: TextStyle(
                                          fontFamily: "SignikaSemiBold",
                                          color: Colors.white,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Passwords are not the same.',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ));
                                    } else if (passwordController.text.length <
                                        6) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Password must be atleast 6 characters length.',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ));
                                    } else {
                                      var statusOK = await signup(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          isSelected[0],
                                          isSelected[1],
                                          context);
                                      if (statusOK) {
                                        // if signup is successful
                                        if (isSelected[0]) {
                                          // if teacher
                                          Navigator.pushNamed(
                                              context, '/login');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              'Sign Up Successful!\n Please Log In.',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ));
                                        } else {
                                          // if student, need to submit photo of face
                                          Navigator.pushNamed(
                                              context, '/submitface');
                                        }
                                      } else {
                                        // if signup is unsuccessful
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Sign Up Failed!\n Please try again.',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ));
                                      }
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

String url = 'https://$BASE_URL/users/signup/';
// ignore: prefer_typing_uninitialized_variables
var response;
Future signup(username, email, password, teacher, student, context) async {
  try {
    response = await http.post(Uri.parse(url), body: {
      // send the collected data for creating a new user
      "username": username,
      "email": email,
      "password": password,
      "is_teacher": teacher.toString(),
      "is_student": student.toString()
    });
    Map<String, dynamic> data =
        jsonDecode(response.body); // decode the response
    if (response.statusCode == 200) {
      String token = data["token"];
      FlutterStorage.writeVal(
          'token', token); // store the token in the flutter storage
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // show the error message
        content: Text(
          data['message'],
          style: const TextStyle(color: Colors.red),
        ),
      ));
      return false;
    }
  } catch (e) {
    // when the user uses an already registered email or username
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        // "Existing Username or Email.",
        e.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
    ));
    return false;
  }
}
