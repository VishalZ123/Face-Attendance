import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String date = '';

class Marked extends StatefulWidget {
  const Marked({
    super.key,
    required this.user,
  });

  final String user;

  @override
  State<Marked> createState() {
    return _MarkedState();
  }
}

class _MarkedState extends State<Marked> {
  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    date = formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage('assets/marked.gif'), fit: BoxFit.cover),
            const SizedBox(height: 20),
            const Text(
              'Attendance Marked',
              style: TextStyle(
                  fontFamily: 'SignikaSemiBold',
                  fontSize: 20,
                  color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              widget.user,
              style: const TextStyle(
                  fontFamily: 'SignikaSemiBold',
                  fontSize: 20,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              date,
              style: const TextStyle(
                  fontFamily: 'SignikaSemiBold',
                  fontSize: 20,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/teacher', (Route<dynamic> route) => false);
              },
              child: const Text('OK'),
            ),
          ],
        ));
  }
}
