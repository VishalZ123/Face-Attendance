import 'package:flutter/material.dart';
import 'side_panel.dart';
import '../attendance/attendancesheet.dart';
import '../token_storage.dart';

String username = '';

class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({Key? key}) : super(key: key);

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
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
          title: const Text('Student Dashboard'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: SafeArea(
            child: Center(
          child: Column(children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttendanceSheet(
                              username: username,
                            )));
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
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                )
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
          ]),
        )));
  }
}
