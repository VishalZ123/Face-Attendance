import 'package:flutter/material.dart';
  
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Face Attendance';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text(_title),
        //   backgroundColor: Colors.blue,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/home_bg.png'),
                height: 300,
                width: 200,
              ),
              const Text(
                'Face Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 100),
              Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      icon: const Icon(Icons.person),
                      label: const Text('Login'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Register'),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}