import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadTest extends StatefulWidget {
  @override
  _UploadTestState createState() => _UploadTestState();
}

class _UploadTestState extends State<UploadTest> {
  static final String uploadEndPoint =
      'http://local.aungads.com/api/v1/product/addProduct';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  getImage() {
    var image = ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = image;
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  uploadImage() {
    setStatus('Uploading Image ...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker Example'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  getImage();
                },
                child: Text("Choose Image"),
              ),
              SizedBox(
                height: 20,
              ),
              showImage(),
              SizedBox(
                height: 20,
              ),
              OutlineButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text("Upload Image"),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              )
            ],
          ),
        ));
  }
}
