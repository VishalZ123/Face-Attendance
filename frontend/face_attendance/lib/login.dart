import 'package:flutter/material.dart';

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
                        margin: const EdgeInsets.fromLTRB(10, 200, 10, 100),
                        elevation: 2.0,
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          width: 360.00,
                          height: 300.00,
                          child: Column(
                            children: <Widget>[
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
