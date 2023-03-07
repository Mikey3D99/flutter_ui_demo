import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widgets/add_photo/border_widget.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/constants/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:camera/camera.dart';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({Key? key}) : super(key: key);

  @override
  AddPhotoWidgetState createState() => AddPhotoWidgetState();
}

class AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? _image;
  late CameraController _cameraController;
  List<CameraDescription>? _cameras;

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

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.low, // 4:3
      enableAudio: false,
    );

    await _cameraController.initialize();
    await _cameraController.setFlashMode(FlashMode.off); // flash off
    await _cameraController.setExposureMode(ExposureMode.locked); //
    await _cameraController.setExposureOffset(iso100); // 10 EV == ISO 100
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
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


  Future capturePhoto() async {
      try {
        final XFile imageFile = await _cameraController.takePicture();
        if (imageFile != null) {
          setState(() {
            _image = File(imageFile.path);
          });
        } else {
          notification(toastPhotoNotTaken);
        }
      } catch (e) {
        notification(toastCameraError);
      }
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
                      onPressed: () => capturePhoto(),
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
