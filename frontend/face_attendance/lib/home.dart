import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String _title = 'Face Attendance';

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Home._title,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Image(
                image: AssetImage('assets/home_bg.png'), // image
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
              Row(children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login'); // login button
                      },
                      icon: const Icon(Icons.person),
                      label: const Text('Log In'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup'); // signup button
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Sign Up'),
                    ),
                  ),
                ),
              ]),
              const Text(
                'Made with ❤️ by Vishal',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ), // footer
            ],
          ),
        ),
      ),
    );
  }
}
