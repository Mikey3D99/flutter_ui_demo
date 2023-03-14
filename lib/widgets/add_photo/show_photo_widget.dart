import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/constants/constants.dart';
import 'package:camera/camera.dart';

import 'add_photo_widget.dart';

class ShowPhotoWidget extends StatefulWidget {
  const ShowPhotoWidget({Key? key}) : super(key: key);

  @override
  ShowPhotoWidgetState createState() => ShowPhotoWidgetState();
}

class ShowPhotoWidgetState extends State<ShowPhotoWidget> {
  late CameraController _cameraController;
  List<CameraDescription>? _cameras;
  File? _image;
  bool _showCameraPreview = false;



  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.low, // 4:3
      enableAudio: false,
    );

    await _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        if (_cameraController.value.isInitialized) {
          _showCameraPreview = true;
        }
      });
    });
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

  Future capturePhoto(BuildContext context) async {
    try {
      final XFile imageFile = await _cameraController.takePicture();
      if (imageFile != null) {
        setState(() {
          _image = File(imageFile.path);
          _redirectToAddPhotoWidget(context);
        });
      } else {
        notification(toastPhotoNotTaken);
      }
    } catch (e) {
      notification(toastCameraError);
    }
  }


  void _redirectToAddPhotoWidget(BuildContext context) {Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  AddPhotoWidget(imageFile: _image!)));
  }

  @override
  Widget build(BuildContext context) {
    if (_showCameraPreview) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(showPhotoWidget),
          ),
          body: BackgroundContainer(
            child: Center(
              child: Column(
                children: [
                  CameraPreview(_cameraController),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => capturePhoto(context),
                      child: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(showPhotoWidget),
        ),
        body: const BackgroundContainer(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }

// stateful logic and variables here
}
