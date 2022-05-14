import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Face Attendance';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            body: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: const NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Facial_Recognition22.jpg/1125px-Facial_Recognition22.jpg?20201029165749"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                )),
                child: const LoginWidget())));
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Face Attendance',
                  style: TextStyle(
                      color: Color.fromARGB(255, 153, 209, 255),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Color.fromARGB(255, 153, 209, 255),)
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 153, 209, 255)),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
          ],
        ));
  }
}
