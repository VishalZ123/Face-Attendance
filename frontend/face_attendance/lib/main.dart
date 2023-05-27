import 'package:camera/camera.dart';
import 'package:face_attendance/loading.dart';
import 'package:flutter/material.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'home.dart';
import 'camera/photocapture.dart';
import 'dashboard/student.dart';
import 'dashboard/teacher.dart';

void main() async {
  // get all the cameras and open front camera
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final frontCamera = cameras.last;
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/login': (context) => const Login(),
      '/signup': (context) => const Signup(),
      '/submitface': (context) => TakePictureScreen(
            camera: frontCamera,
            link:
                'https://face-attendance-msengage.herokuapp.com/attendance/submit-face/',
          ),
      '/student': (context) => const StudentDashBoard(),
      '/teacher': (context) => const TeacherDashBoard(),
    },
  ));
}
