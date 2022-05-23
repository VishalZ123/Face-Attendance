import 'package:camera/camera.dart';
import 'package:face_attendance/loading.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'login.dart';
import 'user.dart';
import 'photos.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final backCamera = cameras.first;
  final frontCamera = cameras.last;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/login': (context) => const Login(),
      '/signup': (context) => const Signup(),
      '/user': (context) => const User(),
      '/submitface': (context) => TakePictureScreen(camera:frontCamera,),
    },
  ));
}
