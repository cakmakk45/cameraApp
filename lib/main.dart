
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    title: "Kamera Uygulaması",
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: cameraApp(),
  ));
}

class cameraApp extends StatefulWidget {
  _cameraAppState createState() => _cameraAppState();
}

class _cameraAppState extends State<cameraApp> {
   var  imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final ImagePicker _picker = ImagePicker();
  _openGallary(BuildContext context) async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await _picker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiseDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Birini seçin"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Galeri"),
                      onTap: () {
                        _openGallary(context);
                      },
                    ),
                    GestureDetector(
                      child: const Text("Kamera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("Resim seçilmedi");
    } else {
      return Image.file(
        imageFile,
        width: 400,
        height: 400,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _decideImageView(),
            RaisedButton(
              color: Colors.pink,
              onPressed: () {
                _showChoiseDialog(context);
              },
              child: Text("Resim Seçin!"),
            )
          ],
        )),
      ),
    );
  }
}
