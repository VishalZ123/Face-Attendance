import 'package:flutter/material.dart';
import 'side_panel.dart';
import '../attendance/scan_face.dart';
import 'package:camera/camera.dart';
import '../token_storage.dart';
import 'student_list.dart';

String username = '';

class TeacherDashBoard extends StatefulWidget {
  const TeacherDashBoard({Key? key}) : super(key: key);

  @override
  State<TeacherDashBoard> createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  void initState() {
    super.initState();
    TokenStorage.readToken('username').then((value) {
      if (value != null) {
        username = value;
      } else {
        username = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidePanel(),
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
                        'http://172.31.54.122:8000/attendance/mark-attendance/',
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
