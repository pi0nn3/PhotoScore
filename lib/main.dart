import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(PhotoScoreApp());
}

class PhotoScoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhotoScore',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PhotoScoreHomePage(),
    );
  }
}

class PhotoScoreHomePage extends StatefulWidget {
  @override
  _PhotoScoreHomePageState createState() => _PhotoScoreHomePageState();
}

class _PhotoScoreHomePageState extends State<PhotoScoreHomePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhotoScore'),
        backgroundColor: Colors.amber[600],
      ),
      body: Center(
        child: _image == null
            ? Text(
                'Fotoğraf Seçilmedi',
                style: TextStyle(fontSize: 24),
              )
            : Stack(
                children: [
                  Image.file(_image!),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: _deleteImage,
                      child: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showOptions(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 255, 179, 3),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.amber[50],
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.amber[600]),
                title: Text(
                  'Kamera',
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.amber[600]),
                title: Text(
                  'Galeri',
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
