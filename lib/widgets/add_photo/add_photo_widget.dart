import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/constants/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({Key? key}) : super(key: key);

  @override
  AddPhotoWidgetState createState() => AddPhotoWidgetState();
}

class AddPhotoWidgetState extends State<AddPhotoWidget> {
  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void handleImportButton(BuildContext context) {

  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text(addPhotoButtonText),
        ),
        body: BackgroundContainer(
            child: Column(
                children: [
                  _image == null ? Container(
                    margin: const EdgeInsets.all(10.0),
                    width: screenHeight / 2,
                    height: screenHeight / 2,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white70,
                        ),
                        borderRadius: BorderRadius.circular(cornerRadius),
                    ),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: Icon(
                            Icons.image,
                            color: Colors.white70,
                            size: constraints.maxWidth * 0.3,
                          ),
                        );
                      },
                    ),
                  ) : Container(
                    margin: const EdgeInsets.all(10.0),
                    width: screenHeight / 2,
                    height: screenHeight / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.white70,
                      ),
                      borderRadius: BorderRadius.circular(cornerRadius),
                    ),
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
                          onPressed: () => handleImportButton(context),
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
