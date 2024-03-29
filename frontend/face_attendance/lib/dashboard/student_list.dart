import 'dart:convert';
import 'package:face_attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../attendance/attendancesheet.dart';

List<String> students = [];

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  void initState() {
    super.initState();
    getStudents().then((value) {
      setState(() {
        students = value;
      });
    });
  }
 // A widh=get to display the list of all the students
 // teacher may choose to view the attendance of the selected student
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendanceSheet(
                                username: students[index],
                              )));
                },
                child: Card(
                  color:
                      (index % 2 == 0) ? Colors.blue[100] : Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            students[index],
                            style: const TextStyle(
                              fontFamily: 'SignikaSemiBold',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          )
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String url = 'https://$BASE_URL/attendance/get-students/';
  Future getStudents() async {
    try {
      var response = await http.get(Uri.parse(url)); //  get the list of students
      List<dynamic> jsonResponse = json.decode(response.body);
      List<String> studentList = [];
      for (var i = 0; i < jsonResponse.length; i++) { // for each user get the username
        String username = jsonResponse[i]['username'];
        studentList.add(username);
      }
      return studentList;
    } catch (e) {
      throw '';
    }
  }
}
