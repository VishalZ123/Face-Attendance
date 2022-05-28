import 'package:flutter/material.dart';
import '../token_storage.dart';

String username = '';
String role = '';
String email = '';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
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
    TokenStorage.readToken('email').then((value) {
      if (value != null) {
        email = value;
      } else {
        email = '';
      }
    });
    TokenStorage.readToken('role').then((value) {
      if (value != null) {
        role = value;
      } else {
        role = '';
      }
    });
  }

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
            child: Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SignikaSemiBold'),
            ),
          ),
          ListTile(
            title: Column(
              children: [
                const SizedBox(height: 20),
                Text(username),
                const SizedBox(height: 20),
                Text(role),
                const SizedBox(height: 20),
                Text(email),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              TokenStorage.deleteToken('token'),
              TokenStorage.deleteToken('role'),
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false)
            },
          ),
        ],
      ),
    );
  }
}
