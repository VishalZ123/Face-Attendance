import 'package:flutter/material.dart';
import 'package:http/http.dart';
//Widget for input
String toString(bool b) {
  return b ? "true" : "false";
}
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
  final TextEditingController confirmPasswordController =  TextEditingController();
  List<bool> isSelected = [false, false];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                        elevation: 2.0,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          width: 360.00,
                          height: 560.00,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
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
                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
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
                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                child: ToggleButtons(
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    //   content: Text('${toString(isSelected[0])} ${toString(isSelected[1])}'),
                                    // ));
                                  },
                                  isSelected: isSelected,
                                  children: const <Widget>[
                                    // Icon(Icons.ac_unit),
                                    // SizedBox(height: 5.0,),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                                        child: Text("Teacher",
                                            style: TextStyle(
                                            fontFamily: "SignikaSemiBold",
                                            color: Colors.black,
                                            fontSize: 22.0),
                                        )
                                    ),
                                    // Icon(Icons.call),
                                    // SizedBox(height: 5.0,),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                                        child: Text("Student",
                                        style: TextStyle(
                                            fontFamily: "SignikaSemiBold",
                                            color: Colors.black,
                                            fontSize: 22.0),)
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 20.0, left: 25.0, right: 25.0),
                                child: TextField(
                                  controller: passwordController,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Enter password",
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
                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                child: TextField(
                                  controller: passwordController,
                                  style: const TextStyle(
                                      fontFamily: "SignikaSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.password,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: "Confirm password",
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
                                  onPressed: () {
                                    Navigator.pop(context);
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
