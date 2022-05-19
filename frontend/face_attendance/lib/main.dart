import 'package:face_attendance/loading.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'login.dart';
import 'signup.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup()
      },
    ));
