import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';

// simulate loading for the splash screen
// for the purpose of advertisement

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3), // wait for 3 seconds
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
