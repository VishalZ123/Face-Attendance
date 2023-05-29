import 'dart:convert';
import 'package:face_attendance/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AttendanceSheet extends StatefulWidget {
  final String username;

  const AttendanceSheet({super.key, required this.username});

  @override
  State<AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  List attendance = [];
  @override
  void initState() {
    super.initState();
    fetchAttendance(widget.username).then((value) { // get the attendance list
      setState(() {
        attendance = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Sheet'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(widget.username,
                  style: const TextStyle(
                      fontFamily: 'SignikaSemiBold',
                      fontSize: 20,
                      color: Colors.black)),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Date',
                      style: TextStyle(
                        fontFamily: 'SignikaSemiBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  Text('Time',
                      style: TextStyle(
                        fontFamily: 'SignikaSemiBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ))
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder( // list of attendances
                  itemCount: attendance.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Card(
                        color: (index % 2 == 0) ? Colors.blue : Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  attendance[index]['date'],
                                  style: const TextStyle(
                                    fontFamily: 'SignikaSemiBold',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  attendance[index]['time'],
                                  style: const TextStyle(
                                    fontFamily: 'SignikaSemiBold',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future fetchAttendance(String username) async {
  String url =
      'https://$BASE_URL/attendance/get-attendance/';
  try {
    var response = await http.post(Uri.parse(url), headers: { // send username to server
      'username': username,
    });
    List<dynamic> attendance = json.decode(response.body); // get the attendance list
    List<Map<String, String>> datelist = [];
    for (var i = 0; i < attendance.length; i++) { // for each day, seperate the date and time to display separately
      DateTime dateTime = DateTime.parse(attendance[i]['dateTime']);
      String date = DateFormat('dd-MM-yyyy').format(dateTime);
      String time = DateFormat('hh:mm:ss').format(dateTime);
      datelist.add({'date': date, 'time': time});
    }
    return datelist;
  } catch (e) {
    throw '';
  }
}
