import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token= loadToken();

loadToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = (prefs.getString('Token')??'');
  return token;
}

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
  Function tempname(){
    Future homeroute(){
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
    Future userroute(){
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const User()));
    }
    if(token==''){
      return homeroute;
    }else{
      return userroute;
    }
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
