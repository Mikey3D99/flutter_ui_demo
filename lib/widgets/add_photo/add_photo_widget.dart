import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widgets/add_photo/border_widget.dart';
import 'package:flutter_ui_demo/widgets/add_photo/show_photo_widget.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/constants/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

void notification(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

class AddPhotoWidget extends StatefulWidget {
  final File imageFile;
  const AddPhotoWidget({Key? key, required this.imageFile}) : super(key: key);

  @override
  AddPhotoWidgetState createState() => AddPhotoWidgetState();
}

class AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.imageFile.existsSync()) {
      _image = widget.imageFile;
    }
  }


  Future getImage() async {
    notification(toastBetterImageQuality);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
          notification(toastNoImageSelected);
      }
    });
  }

  void _handleCapture(BuildContext context) {Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ShowPhotoWidget()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text(addPhotoButtonText),
        ),
        body: BackgroundContainer(
          child: Column(children: [
            _image == null
                ? BorderContainer(
                    child: Icon(
                      Icons.image,
                      color: Colors.white70,
                      size: (screenHeight / 6),
                    ),
                  )
                : BorderContainer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(cornerRadius),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <SizedBox>[
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => getImage(),
                      child: const Text(
                        importButtonText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _handleCapture(context),
                      child: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
// stateful logic and variables here
}
