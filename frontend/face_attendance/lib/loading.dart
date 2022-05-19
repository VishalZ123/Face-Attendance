import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';

// void main() {
//   runApp(const Loading());
// }

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/home_bg.png'),
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 50),
                Text(
                  'Face Attendance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 100),
                Text('Loading...'),
                SizedBox(height: 30),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ));
  }
}
