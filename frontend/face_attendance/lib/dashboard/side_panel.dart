import 'package:face_attendance/dashboard/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../storage.dart';

class SidePanel extends StatefulWidget {
  final String username;
  final String role;
  final String email;
  const SidePanel(
      {super.key,
      required this.username,
      required this.role,
      required this.email});

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/home_bg.png'))),
              child: Text('')),
          ListTile(
            title: Column(
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SignikaSemiBold'),
                ),
                const SizedBox(height: 20),
                Text(widget.username),
                const SizedBox(height: 20),
                Text(widget.role),
                const SizedBox(height: 20),
                Text(widget.email),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.person_solid),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ))
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              FlutterStorage.deleteAll(),
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false)
            },
          ),
        ],
      ),
    );
  }
}
