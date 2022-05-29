// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'marked.dart';

class CaptureFace extends StatefulWidget {
  const CaptureFace({
    super.key,
    required this.camera,
    required this.link,
  });

  final CameraDescription camera;
  final String link;

  @override
  CaptureFaceState createState() => CaptureFaceState();
}

class CaptureFaceState extends State<CaptureFace> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera create a CameraController.
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    // Initialize the controller.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture of Face')),
      // You must wait until the controller is initialized before displaying the camera preview.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                  link: widget.link,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            AlertDialog(
              content: Column(
                children: [
                  ListTile(
                    title: Text(e.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                        )),
                  ),
                ],
              ),
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

const storage = FlutterSecureStorage();
String token = '';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final String link;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.link});

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
                Icons.edit_calendar_rounded,
              ),
              label: const Text('  Mark attendance'),
              onPressed: () async {
                List status =
                    await upload(widget.imagePath, widget.link, context);
                if (status[0] == 200) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Marked(user: status[1])));
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/teacher', (Route<dynamic> route) => false);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future upload(path, link, context) async {
    var uri = Uri.parse(link);
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', path));
    var response = await request.send();
    String message = await response.stream.bytesToString();
    var jsonResponse = json.decode(message);
    if (response.statusCode == 200) {
      return [200, jsonResponse['user']];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          jsonResponse['error'],
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      ));
    }
    return [
      response.statusCode,
    ];
  }
}
