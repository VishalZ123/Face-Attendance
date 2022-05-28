// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

const storage = FlutterSecureStorage();
String token = '';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final String link;

  const DisplayPictureScreen({super.key, required this.imagePath, required this.link});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  void initState() {
    super.initState();
    storage.read(key: 'token').then((value) {
      if (value != null) {
        token = value;
      } else {
        token = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.file(File(widget.imagePath)),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
              ),
              label: const Text('Submit Face'),
              onPressed: () async {
                var statuscode = await upload(
                    widget.imagePath,
                    widget.link,
                    context);
                if (statuscode == 200) {
                  Navigator.pushNamed(context, '/login');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Sign Up Successful!\n Please Log In.',
                      style: TextStyle(color: Colors.green),
                    ),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  upload(String path, String url, context) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.headers['Token'] = token;
    request.files.add(await http.MultipartFile.fromPath('image', path));
    var response = await request.send();

    String message = await response.stream.bytesToString();
    var jsonResponse = json.decode(message);
    message = jsonResponse['message'];
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (message == null) {
      message = 'Something went wrong, ensure you scanned your face correctly.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ));
    return response.statusCode;
  }
}
