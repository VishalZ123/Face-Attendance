import 'package:flutter/material.dart';
import 'side_panel.dart';
import '../attendance/scan_face.dart';
import 'package:camera/camera.dart';
import '../storage.dart';
import 'student_list.dart';

String username = '';
String role = '';
String email = '';

class TeacherDashBoard extends StatefulWidget {
  const TeacherDashBoard({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoard> createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  void initState() {
    super.initState();
    FlutterStorage.readAll().then((value) {
      setState(() {
        username = value['username'];
        email = value['email'];
        role = value['role'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidePanel(username: username, role: role, email: email),
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              WidgetsFlutterBinding.ensureInitialized();
              final cameras = await availableCameras();
              final frontCamera = cameras.last;
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaptureFace(
                    camera: frontCamera,
                    link:
                        'http://IP_ADDRESS:8000/attendance/mark-attendance/',
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Material(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Mark Attendance",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              )
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentList(),
                ),
              );
            },
            child: Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Material(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("View Attendance",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              )
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      )),
    );
  }
}
